export function initUploaderWidgets() {
    document.querySelectorAll('.uploader-widget-wrapper').forEach((uploader) => {
        const uploaderId = uploader.getAttribute('id');
        new Dropzone(`#${uploaderId} .uploader-widget__dropzone`, {
            // stub url provided since dropzone requires url
            url: '/#',
            autoProcessQueue: false,
            autoQueue: false,
            addedfile: file => onFileAdded(file, uploader)
        });

        const formInput = document.querySelector(`#${uploaderId} input`);
        console.log('forminput value', formInput.value)
        if (formInput.value) {
            updateUploaderPreview(uploader, formInput.value);
            // TODO: refactor this
            const input = document.querySelector(`#${uploaderId}  input`);
            input.classList.add('untouched')
        }
    });
}

function onFileAdded(file, uploader) {
    const reader = new FileReader();

    reader.onloadend = (e) => {
        updateUploaderPreview(uploader, e.target.result);
        updateFieldValue(uploader, e.target.result);
    }

    reader.readAsDataURL(file);
}

function updateUploaderPreview(uploader, preview) {
    const uploaderId = uploader.getAttribute('id');
    const previewContainer = document.querySelector(`#${uploaderId}  .uploader-widget__preview`);
    previewContainer.querySelector('img').setAttribute('src', preview);
    previewContainer.classList.add('is-active');
}

function updateFieldValue(uploader, value) {
    const uploaderId = uploader.getAttribute('id');
    const formInput = document.querySelector(`#${uploaderId} input`);
    formInput.value = value;
    clearFieldErrors(formInput);
}

function clearFieldErrors(input) {
    input.removeAttribute('aria-invalid');

    if (input.nextElementSibling && input.nextElementSibling.classList.contains('app-input-error')) {
        input.nextElementSibling.remove();
    }
}

