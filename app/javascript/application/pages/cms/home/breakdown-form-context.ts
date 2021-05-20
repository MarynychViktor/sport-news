import { filter, tap } from "rxjs/operators";

// @ts-ignore
import { Select } from "application/components/select";

export class BreakdownFormContextRegistry {
  private static contexts: {[key: string]: BreakdownFormContext} = {};

  static addContext(formId: string)  {
    this.contexts[formId] = new BreakdownFormContext(`#${formId}`);
  }

  static get(formId: string) {
    return this.contexts[formId];
  }
}

export class BreakdownFormContext {
  private categorySelect: Select;
  private subcategorySelect: Select;
  private teamSelect: Select;

  constructor(private formSelector: string) {
    this.init();
  }

  clear() {
    this.categorySelect.clear();
    this.subcategorySelect.clear();
    this.teamSelect.clear();
  }

  reset() {
    this.subcategorySelect.clear();
    this.teamSelect.clear();
  }

  destroy() {
    this.categorySelect.destroy();
    this.subcategorySelect.destroy();
    this.teamSelect.destroy();
  }

  private init() {
    this.createCategorySelect();
    this.createSubcategorySelect();
    this.createTeamSelect();
    this.enableSelectsSynchronization();
  }

  private enableSelectsSynchronization() {
    // TODO: fix bugs with disabled-enabled selects
    this.categorySelect.initialized$.subscribe(val => {

    });

    this.categorySelect.changed$.pipe(
      tap((value) => {
        if (!value) {
          this.subcategorySelect.disableWithClear();
        } else {
          this.subcategorySelect.clear();
        }
      }),
      filter((value) => !!value),
      tap(() => this.subcategorySelect.enable())
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
  }

  private createCategorySelect() {
    this.categorySelect = new Select(`${this.formSelector} .breakdowns-form__category-field`, {
      placeholder: 'Select a category',
      ajax: { url: `/cms/categories` },
    });
  }

  private createSubcategorySelect() {
    this.subcategorySelect = new Select(`${this.formSelector} .breakdowns-form__subcategory-field`, {
      placeholder: 'Select a subcategory',
      ajax: {
        url: () => {
          return `/cms/categories/${this.categorySelect.getValue()}/subcategories`;
        },
      },
    });
  }

  private createTeamSelect() {
    this.teamSelect = new Select(`${this.formSelector} .breakdowns-form__team-field`, {
      placeholder: 'Select a team',
      ajax: {
        url: () => {
          return `/cms/subcategories/${this.subcategorySelect.getValue()}/teams`;
        },
      },
    });
  }
}
