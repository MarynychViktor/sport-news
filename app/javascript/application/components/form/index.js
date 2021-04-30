export function clearErrorsOnFormField() {
    document.querySelectorAll('input[aria-invalid=true]').forEach((input) => {
        input.addEventListener('input', clearInputErrors);
    });

    function clearInputErrors(event) {
        const input = event.target;
        input.removeAttribute('aria-invalid');
        const error = input.nextElementSibling;

        if (error && error.classList.contains('app-input-error')) {
            error.remove();
        }

        input.removeEventListener('input', clearInputErrors);
    }
}


