import { clearSimpleFormFieldsErrorsOnFocus, initFormSelects } from './helpers';
import { renderAdminMenuSlider } from './helpers/menu/menu';
import { initUploaderWidgets } from './components/uploader-widget';
import { customerMenu } from './helpers/menu/customer-menu';

document.addEventListener('DOMContentLoaded', () => {
    initFormSelects();
    initUploaderWidgets();
    renderAdminMenuSlider();
    clearSimpleFormFieldsErrorsOnFocus();
    customerMenu();
});