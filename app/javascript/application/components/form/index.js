export function clearErrorsOnFormField() {
    document.querySelectorAll('input[aria-invalid=true]').forEach((input) => {
        input.addEventListener('focus', clearInputErrors);
    });

    function clearInputErrors(event) {
        const input = event.target;
        input.removeAttribute('aria-invalid');
        const error = input.nextElementSibling;

        if (error && error.classList.contains('app-input-error')) {
            error.remove();
        }

        input.removeEventListener('focus', clearInputErrors);
    }
}

export function clearErrorsOnReachTextField() {
    document.querySelectorAll('.ck-editor__editable').forEach((editor) => {
        editor.addEventListener('focus', clearRichTextFieldErrors);
    });

    function clearRichTextFieldErrors({target}) {
        const formGroup = target.closest('.app-form-group');
        formGroup.querySelector('.field_with_errors').classList.remove('field_with_errors');
        const error = formGroup.querySelector('.app-input-error');

        if (error) {
            error.remove();
        }

        target.removeEventListener('focus', clearRichTextFieldErrors);
    }
}