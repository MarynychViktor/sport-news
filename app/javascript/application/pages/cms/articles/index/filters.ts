import { Select } from "application/components/select";
import { merge } from "rxjs";
import { tap } from "rxjs/operators";

declare const _context: {category: any, last_page: boolean};
const {category} = _context;

const filtersForm = document.querySelector('#filters form') as HTMLFormElement;

const subcategoriesFilter = new Select('#subcategory-filter', {
  placeholder: 'Select a subcategory',
  ajax: { url: `/cms/categories/${category.id}/subcategories` },
})

const teamsFilter = new Select('#team-filter', {
  placeholder: 'Select a team',
  ajax: {
    url: function () {
      const subcategory = subcategoriesFilter.getValue();
      if (subcategory) {
        return `/cms/subcategories/${subcategory}/teams`;
      }
      return '/cms/teams';
    },
  },
});

merge(
  subcategoriesFilter.changed$.pipe(tap(() => teamsFilter.clear())),
  teamsFilter.changed$
).subscribe(() => filtersForm.submit());


// createSelect('#published-filter', {
//   allowEmptyOption: true,
//   onChange(value) {
//     if (value !== undefined) {
//       const form = this.$input.closest('form');
//       form.submit();
//     }
//   }
// });
