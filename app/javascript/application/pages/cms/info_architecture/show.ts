import Sortable from 'sortablejs/modular/sortable.core.esm';
declare const window: any;

enableOrderingForCategories();
registerCloseListener();
window.enableOrderingForSubcategories = enableOrderingForSubcategories;
window.enableOrderingForTeams = enableOrderingForTeams;
window.registerCloseListener = registerCloseListener;

function registerCloseListener() {
  document.querySelectorAll('.categorized-item-wrapper').forEach(item => {
    const onMouseLeave = () => {
      const menu = item.querySelector('.dropdown-menu.show');

      if (menu) {
        menu.classList.remove('show');
      }

      item.removeEventListener('mouseleave', onMouseLeave);
    };

    item.addEventListener('mouseenter', () => {
      item.addEventListener('mouseleave', onMouseLeave);
    });
  });
}

function enableOrderingForCategories() {
  makeCategorizedItemSortable({
    selector: '#categories-list',
    onItemPositionChanged: (item, newPosition) => {
      const id = parseInt(item.getAttribute('data-id'));
      return updateResourcePosition(`/cms/categories/${id}/position`, newPosition);
    }
  })
}

function enableOrderingForSubcategories() {
  makeCategorizedItemSortable({
    selector: '.ia-subcategories__list',
    onItemPositionChanged: (item, newPosition) => {
      const id = parseInt(item.getAttribute('data-id'));
      const categoryId = parseInt(item.getAttribute('data-category-id'));
      return updateResourcePosition(`/cms/categories/${categoryId}/subcategories/${id}/position`, newPosition);
    }
  })
}

function enableOrderingForTeams() {
  makeCategorizedItemSortable({
    selector: '.ia-teams__list',
    onItemPositionChanged: (item, newPosition) => {
      const id = parseInt(item.getAttribute('data-id'));
      const subcategoryId = parseInt(item.getAttribute('data-subcategory-id'));
      return updateResourcePosition(`/cms/subcategories/${subcategoryId}/teams/${id}/position`, newPosition);
    }
  })
}

function makeCategorizedItemSortable({selector, onItemPositionChanged}) {
  const target = document.querySelector(selector);
  if (target) {
    Sortable.create(target, {
      handle: '.categorized-item__content',
      onEnd: ({oldIndex, newIndex, item}) => (oldIndex !== newIndex) && onItemPositionChanged(item, newIndex)
    });
  }
}

function updateResourcePosition(path, position) {
  return fetch(path, {
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    method: 'POST', body: JSON.stringify({position})
  })
    .then(res => res.text());
}