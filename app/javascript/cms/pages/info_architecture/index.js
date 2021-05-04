// import Sortable from 'sortablejs/modular/sortable.core.esm';
//
// export class InfoArchitecturePage {
//     static init() {
//         if ('InfoArchitecture' === window.resource) {
//             const page = new InfoArchitecturePage();
//             page.onInit();
//             window.InfoArchitecture = page;
//         }
//     }
//
//     onInit() {
//         this.makeCategoriesSortable();
//         $('#modal').on('hidden.bs.modal', () => $('#modal-content').empty());
//     }
//
//     makeCategoriesSortable() {
//         this.makeCategorizedItemSortable({
//             selector: '#categories-list',
//             onItemPositionChanged: (item, newPosition) => {
//                 const id = parseInt(item.getAttribute('data-id'));
//                 return this.updateResourcePosition(`/cms/categories/${id}/position`, newPosition);
//             }
//         })
//     }
//
//     makeSubcategoriesSortable() {
//         this.makeCategorizedItemSortable({
//             selector: '.ia-subcategories__list',
//             onItemPositionChanged: (item, newPosition) => {
//                 const id = parseInt(item.getAttribute('data-id'));
//                 const categoryId = parseInt(item.getAttribute('data-category-id'));
//                 return this.updateResourcePosition(`/cms/categories/${categoryId}/subcategories/${id}/position`, newPosition);
//             }
//         })
//     }
//
//     makeTeamsSortable() {
//         this.makeCategorizedItemSortable({
//             selector: '.ia-teams__list',
//             onItemPositionChanged: (item, newPosition) => {
//                 const id = parseInt(item.getAttribute('data-id'));
//                 const subcategoryId = parseInt(item.getAttribute('data-subcategory-id'));
//                 return this.updateResourcePosition(`/cms/subcategories/${subcategoryId}/teams/${id}/position`, newPosition);
//             }
//         })
//     }
//
//     makeCategorizedItemSortable({selector, onItemPositionChanged}) {
//         const target = document.querySelector(selector);
//         if (target) {
//             Sortable.create(target, {
//                 handle: '.categorized-item__content',
//                 onEnd: ({oldIndex, newIndex, item}) => (oldIndex !== newIndex) && onItemPositionChanged(item, newIndex)
//             });
//         }
//     }
//
//     updateResourcePosition(path, position) {
//         return fetch(path, {
//             headers: {
//                 'Content-Type': 'application/json',
//                 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
//             },
//             method: 'POST', body: JSON.stringify({position})
//         })
//             .then(res => res.text());
//     }
// }
