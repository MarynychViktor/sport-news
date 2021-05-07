import { filter, tap } from "rxjs/operators";
import { stringify } from 'query-string'

import { Select } from "application/components/select";

// declare const _context: {category: any, last_page: boolean};
//
// const {category} = _context;

const categorySelect = new Select('#category_id', {
  placeholder: 'Select a category',
  ajax: { url: `/cms/categories` },
});

const subCategorySelect = new Select('#subcategory_id', {
  placeholder: 'Select a subcategory',
  ajax: {
    url: function () {
      return `/cms/categories/${categorySelect.getValue()}/subcategories`;
    },
  },
});

const teamSelect = new Select('#team_id', {
  placeholder: 'Select a team',
  ajax: {
    url: function () {
      return `/cms/subcategories/${subCategorySelect.getValue()}/teams`;
    },
  },
});


subCategorySelect.changed$.pipe(
  tap((value) => {
    if (!value) {
      teamSelect.clear();
      teamSelect.disable();
    }
  }),
  filter((value) => !!value),
  tap(() => {
    teamSelect.clear()
    teamSelect.enable();
  })
)
  .subscribe();

subCategorySelect.changed$.subscribe(val => console.log('subcategory change', val))

const articleSelect = new Select('#article_id', {
  placeholder: 'Select article',
  ajax: {
    url: function () {
      const rawParams = {
        subcategory_id: subCategorySelect.getValue(),
        team_id: teamSelect.getValue(),
      };

      const queryParams = {};
      for (const key in Object.keys(rawParams)) {
        if (rawParams[key]) {
          queryParams[key] = rawParams[key];
        }
      }

      const queryString = stringify(queryParams);
      return `/cms/categories/${categorySelect.getValue()}/articles?${queryString}`;
    },
  },
});

categorySelect.changed$.pipe(
  tap((value) => {
    if (!value) {
      subCategorySelect.clear();
      subCategorySelect.disable();
      articleSelect.clear();
      articleSelect.disable();
    }
  }),
  filter((value) => !!value),
  tap(() => {
    subCategorySelect.clear();
    subCategorySelect.enable();
    articleSelect.clear();
    articleSelect.enable();
  })
)
  .subscribe();
//
// const teamsFilter = new Select('#team-filter', {
//   placeholder: 'Select a team',
//   ajax: {
//     url: function () {
//       const subcategory = subcategoriesFilter.getValue();
//       if (subcategory) {
//         return `/cms/subcategories/${subcategory}/teams`;
//       }
//       return '/cms/teams';
//     },
//   },
// });
//
// merge(
//   subcategoriesFilter.changed$.pipe(tap(() => teamsFilter.clear())),
//   teamsFilter.changed$
// ).subscribe(() => filtersForm.submit());
