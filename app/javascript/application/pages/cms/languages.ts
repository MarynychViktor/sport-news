import { Select } from "../../components/select";
import { createEditor, validateYaml } from "./languages/editor";

const select = new Select('#lang-select');
const newLanguageBtn = document.querySelector('#new-language')

if (newLanguageBtn) {
  newLanguageBtn.addEventListener('click', () => ($('#modal') as any).modal('show'));
}

const addLanguageBtn = document.querySelector('#add-language');
if (addLanguageBtn) {
  addLanguageBtn.addEventListener('click',  () => {
    ($('#modal') as any).modal('hide')
  });
}

const editorElement = document.querySelector('#editor');
if (editorElement) {
  const code = editorElement.getAttribute('data-translation')
  const editor = createEditor(code);

  const editLanguageForm = document.querySelector('.edit_language');
  if (editLanguageForm) {
    editLanguageForm.addEventListener('submit', e => {
      e.preventDefault();
      const translationInput: HTMLFormElement = document.querySelector('.edit_language #language_translation');
      translationInput.value = editor.getValue();
      if (!validateYaml(editor.getValue())) {
        console.log('valid');
      } else {
        console.log('with errors');
      }

      (e.target as HTMLFormElement).submit();
    })
  }
}

document.querySelectorAll('.language-visibility-toggle').forEach(element => {
  element.addEventListener('change', e => {
    const checked = (e.target as any).checked;
    const form = (e.target as HTMLElement).closest('form');
    const visibilityInput = form.querySelector('.language-visibility-input');
    (visibilityInput as any).value = !checked;
    form.submit();
  });
});