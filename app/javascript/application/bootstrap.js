import { clearSimpleFormFieldsErrorsOnFocus, initFormSelects } from './helpers';
import { renderAdminMenuSlider } from './helpers/menu/menu';
import { initUploaderWidgets } from './components/uploader-widget';
import { customerMenu } from './helpers/menu/customer-menu';
import { initHeroCarousel } from './helpers/carousel/hero-carousel';
import { setupSearchField } from './helpers/search/search';

document.addEventListener('DOMContentLoaded', () => {
    initFormSelects();
    initUploaderWidgets();
    renderAdminMenuSlider();
    clearSimpleFormFieldsErrorsOnFocus();
    customerMenu();
    initHeroCarousel();
    setupSearchField();
});