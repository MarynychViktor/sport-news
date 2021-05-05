import './index/filters';
import './index/infinite_scroll';
// import { createSelect } from '../../../helpers';
// import { Select } from "application/components/select";
// import { combineLatest, merge } from "rxjs";
// import { tap } from "rxjs/operators";
//
// declare const category: any;
//
// const filtersForm = document.querySelector('#filters form') as HTMLFormElement;
// const subcategoryFilter = new Select('#subcategory-filter', {
//   placeholder: 'Select a subcategory',
//   ajax: {
//     url: `/cms/categories/${category.id}/subcategories`,
//   },
// })
//
// const teamsFilter = new Select('#team-filter', {
//   placeholder: 'Select a team',
//   ajax: {
//     url: function () {
//       const subcategory = subcategoryFilter.getValue();
//
//       if (subcategory) {
//         return `/cms/subcategories/${subcategory}/teams`;
//       }
//
//       return '/cms/teams';
//     },
//   },
// });
// merge(
//   subcategoryFilter.changed$.pipe(tap(() => {teamsFilter.clear();})),
//   teamsFilter.changed$
// ).subscribe(() => {
//   filtersForm.submit();
// });
//
// //
// // createSelect('#subcategory-filter', {
// //   allowEmptyOption: true,
// //   onChange(value) {
// //     if (value !== undefined) {
// //       if (teamFilterSelect) {
// //         teamFilterSelect.setValue('');
// //       }
// //       const form = this.$input.closest('form');
// //       form.submit();
// //     }
// //   }
// // });
//
// // createSelect('#team-filter', {
// //   allowEmptyOption: true,
// //   onChange(value) {
// //     if (value !== undefined) {
// //       const form = this.$input.closest('form');
// //       form.submit();
// //     }
// //   }
// // }).then(selectize => teamFilterSelect = selectize);
//
// createSelect('#published-filter', {
//   allowEmptyOption: true,
//   onChange(value) {
//     if (value !== undefined) {
//       const form = this.$input.closest('form');
//       form.submit();
//     }
//   }
// });
//
// const { clientHeight, scrollTop, scrollHeight } = document.documentElement;
