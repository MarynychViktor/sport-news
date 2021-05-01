import { clearSimpleFormFieldsErrorsOnFocus, initFormSelects } from './helpers';
import { renderAdminMenuSlider } from './helpers/menu/menu';
import { initUploaderWidgets } from './components/uploader-widget';

document.addEventListener('DOMContentLoaded', () => {
    initFormSelects();
    initUploaderWidgets();
    renderAdminMenuSlider();
    clearSimpleFormFieldsErrorsOnFocus();
});