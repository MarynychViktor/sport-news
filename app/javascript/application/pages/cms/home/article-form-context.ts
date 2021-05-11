import { filter, tap } from "rxjs/operators";
import { stringify } from 'query-string'

import { Select } from "application/components/select";
import { merge } from "rxjs";
export class ArticleFormContextRegistry {
  private static contexts: {[key: string]: ArticleFormContext} = {};

  static addContext(formId: string)  {
    this.contexts[formId] = new ArticleFormContext(`#${formId}`);
  }

  static get(formId: string) {
    return this.contexts[formId];
  }
}

export class ArticleFormContext {
  private categorySelect: Select;
  private category: string;

  private subcategorySelect: Select;
  private teamSelect: Select;
  private articleSelect: Select;

  constructor(private formSelector: string) {
    this.init();
  }

  clear() {
    this.categorySelect.clear();
    this.subcategorySelect.clear();
    this.teamSelect.clear();
    this.articleSelect.clear();
  }

  destroy() {
    this.categorySelect.destroy();
    this.subcategorySelect.destroy();
    this.teamSelect.destroy();
    this.articleSelect.destroy();
  }

  private init() {
    this.createCategorySelect();
    this.createSubcategorySelect();
    this.createTeamSelect();
    this.createArticleSelect();
    this.enableSelectsSynchronization();
  }

  private enableSelectsSynchronization() {
    this.categorySelect.changed$.pipe(
      tap((value) => {
        if (!value) {
          this.subcategorySelect.disableWithClear();
        } else {
          this.subcategorySelect.clear();
        }
      }),
      filter((value) => !!value),
      tap(() => {
        this.subcategorySelect.enable();
      }),
      tap((value) => this.category = value)
    )
      .subscribe();

    this.subcategorySelect.changed$.pipe(
      tap((value) => {
        if (!value) {
          this.teamSelect.disableWithClear();
        } else {
          this.teamSelect.clear();
        }
      }),
      filter((value) => !!value),
      tap(() => this.teamSelect.enable())
    )
      .subscribe();

    merge(
      this.categorySelect.changed$,
      this.subcategorySelect.changed$,
      this.teamSelect.changed$
    )
      .pipe(
        tap((value) => {
          if (value) {
            this.articleSelect.clear();
          }
        })
      )
      .subscribe()
  }

  private createCategorySelect() {
    this.categorySelect = new Select(`${this.formSelector} .main-articles-form__category-field`, {
      placeholder: 'Select a category',
      ajax: { url: `/cms/categories` },
    });
  }

  private createSubcategorySelect() {
    this.subcategorySelect = new Select(`${this.formSelector} .main-articles-form__subcategory-field`, {
      placeholder: 'Select a subcategory',
      ajax: {
        url: () => {
          return `/cms/categories/${this.categorySelect.getValue()}/subcategories`;
        },
      },
    });
  }

  private createTeamSelect() {
    this.teamSelect = new Select(`${this.formSelector} .main-articles-form__team-field`, {
      placeholder: 'Select a team',
      ajax: {
        url: () => {
          return `/cms/subcategories/${this.subcategorySelect.getValue()}/teams`;
        },
      },
    });
  }

  private createArticleSelect() {
    this.articleSelect = new Select(`${this.formSelector} .main-articles-form__article-field`, {
      placeholder: 'Select article',
      ajax: {
        processResults (result) {
          return {
            results: result.data.map(({id, headline}) => ({id, text: headline})),
            pagination: {
              more: !result.last_page
            }
          };
        },
        url: () => {
          return `/cms/categories/${this.categorySelect.getValue()}/articles?${this.buildArticlesQueryString()}`;
        },
      },
    });
  }

  private buildArticlesQueryString() {
    const rawParams = {
      subcategory_id: this.subcategorySelect.getValue(),
      team_id: this.teamSelect.getValue(),
    };

    const queryParams = {};
    for (const key of Object.keys(rawParams)) {
      if (rawParams[key]) {
        queryParams[key] = rawParams[key];
      }
    }

    return stringify(queryParams);
  }
}
