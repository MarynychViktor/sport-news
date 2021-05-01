import 'selectize';

export function initFormSelects() {
  createSelect('[data-app-select]')
}

export function createSelect(selector, config) {
  let initialized = false;
  return new Promise(resolve => {
    $(selector).selectize({
      ...config,
      onInitialize() {
        if (config && config.onInitialize) {
          config.onInitialize.bind(this)();
        }

        const value = this.$input.attr('value');

        if (value) {
          this.setValue(value);
        }

        initialized = true;
        resolve(this);
      },
      onFocus: function () {
        clearSimpleFormErrors(document.querySelector(selector))

        if (config && config.onFocus) {
          config.onFocus();
        }
      },
      onChange(value) {
        if (!initialized) {
          return false;
        }

        if (config && config.onChange) {
          config.onChange(value);
        }
      }
    });
  });
}

function clearSimpleFormErrors (target) {
  const fieldWrapper = target.closest('.field_with_errors');

  if (fieldWrapper) {
    fieldWrapper.classList.remove('field_with_errors');
    const error = fieldWrapper.querySelector('.app-input-error');

    if (error) {
      error.remove();
    }

    fieldWrapper.querySelector('select').removeAttribute('aria-invalid');
  }
}