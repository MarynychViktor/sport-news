import { Subject } from "rxjs";
import { tap } from "rxjs/operators";

declare const Dropzone: any;

export function initUploaderWidgets() {
    document.querySelectorAll('.uploader-widget-wrapper')
      .forEach((uploader: HTMLElement) => new UploaderWidget(uploader));
}

class UploaderWidget {
    private id: string;
    private input: HTMLInputElement;
    private dropzone: any;
    private fileLoaded = new Subject<string>();

    constructor(private uploader: HTMLElement) {
        this.init();
    }

    private init() {
        this.setupUploaderElements()
        this.initDropzone();
        this.initWithFormValue();
        this.fileLoaded.pipe(
          tap(dataUrl => this.updateUploaderPreview(dataUrl)),
          tap(dataUrl => {
              this.input.value = dataUrl;
              this.input.classList.remove('untouched');
              this.input.removeAttribute('aria-invalid');
              if (this.input.nextElementSibling && this.input.nextElementSibling.classList.contains('app-input-error')) {
                  this.input.nextElementSibling.remove();
              }
          })
        )
          .subscribe();
    }

    private setupUploaderElements() {
        this.id = this.uploader.getAttribute('id');
        this.input = this.uploader.querySelector('input');
    }

    private initWithFormValue() {
        if (this.input.value) {
            this.updateUploaderPreview(this.input.value);
            this.input.classList.add('untouched')
        }
    }

    private initDropzone() {
        this.dropzone = new Dropzone(`#${this.id} .uploader-widget__dropzone`, {
            // stub url provided since dropzone requires url
            url: '/#',
            autoProcessQueue: false,
            autoQueue: false,
            addedfile: file => {
                const reader = new FileReader();
                reader.onloadend = (e) => this.fileLoaded.next(e.target.result as string);
                reader.readAsDataURL(file);
            }
        });
    }

    private updateUploaderPreview(preview) {
        const previewContainer = document.querySelector(`#${this.id}  .uploader-widget__preview`);
        previewContainer.querySelector('img').setAttribute('src', preview);
        previewContainer.classList.add('is-active');
    }
}
