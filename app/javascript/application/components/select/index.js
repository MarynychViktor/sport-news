class Select {
  constructor(selector, options = {}) {}

  initialize() {

  }
}
// export function initFormSelects() {
//     createSelectize('.app-form-select--selectize');
// }
//
// export function createSelectize(selector, config) {
//     $(selector).selectize({...config, onFocus: function () {
//         clearSelectizeErrors({target: document.querySelector(selector)})
//
//         if (config && config.onFocus) {
//             config.onFocus();
//         }
//     }});
// }
//
// function clearSelectizeErrors ({target}) {
//     const wrapper = target.closest('.field_with_errors');
//     if (wrapper) {
//         wrapper.classList.remove('field_with_errors');
//         const error = wrapper.querySelector('.app-input-error');
//
//         if (error) {
//             error.remove();
//         }
//
//         wrapper.querySelector('select').removeAttribute('aria-invalid');
//     }
// }