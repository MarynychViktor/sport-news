import Sortable from 'sortablejs/modular/sortable.core.esm';
import { Loader } from '@googlemaps/js-api-loader';
declare const window: any;

enableOrderingForCategories();
registerCloseListener();
window.enableOrderingForSubcategories = enableOrderingForSubcategories;
window.enableOrderingForTeams = enableOrderingForTeams;
window.registerCloseListener = registerCloseListener;


const loader = new Loader({
  apiKey: "AIzaSyCfFlMDZQRZujYbOJDz8kJTGyl_BJVCYu8",
  version: "weekly",
  libraries: ["places"]
});
const mapOptions = {
  center: {
    lat: 0,
    lng: 0
  },
  zoom: 4
};
loader
  .load()
  .then(() => {
    new google.maps.Map(document.getElementById("map"), mapOptions);
    console.log('map loaded')
  })
  .catch(e => {
    console.log('err', e)
    // do something
  });

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