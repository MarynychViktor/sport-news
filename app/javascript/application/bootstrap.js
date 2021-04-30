import { clearErrorsOnFormField } from './components/form'
import { initFormSelects } from './components/select'
import { initWidgetUploaders } from './components/uploader-widget';

document.addEventListener('DOMContentLoaded', () => {
    clearErrorsOnFormField();
    initFormSelects();
    initWidgetUploaders();
});