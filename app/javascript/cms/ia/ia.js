// import Sortable from "sortablejs/modular/sortable.core.esm";
//
// function updateResourcePosition(path, position) {
//     return fetch(path, {
//         headers: {
//             'Content-Type': 'application/json',
//             'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
//         },
//         method: 'POST', body: JSON.stringify({position})
//     })
//         .then(res => res.text());
// }
//
// $(document).ready(function () {
//     const target = document.getElementById('categories-list');
//     if (target) {
//         Sortable.create(target, {
//             handle: '.categorized-item__content',
//             onEnd: function (event) {
//                 const target = event.item;
//                 if (event.oldIndex !== event.newIndex) {
//                     const id = parseInt(target.getAttribute('data-id'));
//                     return updateResourcePosition(`/cms/categories/${id}/position`, event.newIndex);
//                 }
//             },
//         });
//     }
//
//     $('#modal').on('hidden.bs.modal', () => $('#modal-content').empty());
// });
//
// (function () {
//     $.fn.iaRefreshSubcategoriesSortable = function () {
//         const target = document.querySelector('.ia-subcategories__list');
//         if (target) {
//             Sortable.create(target, {
//                 handle: '.categorized-item__content',
//                 onEnd: function (event) {
//                     const target = event.item;
//                     if (event.oldIndex !== event.newIndex) {
//                         const id = parseInt(target.getAttribute('data-id'));
//                         const categoryId = parseInt(target.getAttribute('data-category-id'));
//                         return updateResourcePosition(`/cms/categories/${categoryId}/subcategories/${id}/position`, event.newIndex);
//                     }
//                 },
//             });
//         }
//     };
//
//     $.fn.iaRefreshTeamsSortable = function () {
//         const target = document.querySelector('.ia-teams__list');
//         if (target) {
//             Sortable.create(target, {
//                 handle: '.categorized-item__content',
//                 onEnd: function (event) {
//                     const target = event.item;
//                     if (event.oldIndex !== event.newIndex) {
//                         const id = parseInt(target.getAttribute('data-id'));
//                         const subcategoryId = parseInt(target.getAttribute('data-subcategory-id'));
//                         return updateResourcePosition(`/cms/subcategories/${subcategoryId}/teams/${id}/position`, event.newIndex);
//                     }
//                 },
//             });
//         }
//     };
// })()
//
