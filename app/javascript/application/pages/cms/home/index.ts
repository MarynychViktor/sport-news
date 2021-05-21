// @ts-ignore
import { ArticleFormContextRegistry } from "application/pages/cms/home/article-form-context";
// @ts-ignore
import { BreakdownFormContextRegistry } from "application/pages/cms/home/breakdown-form-context";

initArticleForms();
initBreakdownForms();

/** Articles **/
function initArticleForms() {
  document.querySelectorAll('.main-articles-form')
      .forEach(form => ArticleFormContextRegistry.addContext(form.getAttribute('id')));

  document.querySelector('.main-articles-form-add').addEventListener('click', addArticlesForm);
  toggleAddFormButton('.main-articles-form-add-wrapper', document.querySelectorAll('.main-articles-form').length < 5);

  $(document).on('click', '.main-articles-form-remove', (e) => {
    e.target.closest('.main-articles-form').remove();
    toggleAddFormButton('.main-articles-form-add-wrapper', true);
  });
}

function toggleAddFormButton(selector, show: boolean) {
  const addLinkWrapper = document.querySelector(selector) as HTMLElement;
  if (show) {
    addLinkWrapper.style.display = 'block';
  } else if (addLinkWrapper.style.display !== 'none') {
    addLinkWrapper.style.display = 'none';
  }
}

function addArticlesForm() {
  const forms = document.querySelectorAll('.main-articles-form');
  const formPrototype = forms[forms.length - 1];
  ArticleFormContextRegistry.get(formPrototype.getAttribute('id')).destroy();

  const index = parseInt(formPrototype.getAttribute('data-index'));
  const cloned = formPrototype.cloneNode(true) as HTMLElement;
  cloned.setAttribute("data-index", `${index + 1}`);
  cloned.setAttribute('id', `main-articles-form-${index + 1}`);
  $(formPrototype).after(cloned);

  [formPrototype, cloned].forEach(el => ArticleFormContextRegistry.addContext(el.getAttribute('id')));
  ArticleFormContextRegistry.get(cloned.getAttribute('id')).reset();

  setToggleId(cloned, index + 1);

  toggleAddFormButton('.main-articles-form-add-wrapper', forms.length < 4);
}

function setToggleId(target: HTMLElement, id: number) {
  const showToggle = target.querySelector('.main-form__show-field')
  const toggleInput = showToggle.querySelector('input');

  const newId = toggleInput.getAttribute('id').replace(/(?<=-)\d+$/,`${id}`)
  toggleInput.setAttribute('id', newId);

  const toggleLabel= showToggle.querySelector('label');
  toggleLabel.setAttribute('for', newId);
}

/** Breakdowns **/
function initBreakdownForms() {
  document.querySelectorAll('.breakdowns-form')
      .forEach(form => BreakdownFormContextRegistry.addContext(form.getAttribute('id')));

  document.querySelector('.breakdown-form-add').addEventListener('click', addBreakdownForm);
  toggleAddFormButton('.breakdowns-form-add-wrapper', document.querySelectorAll('.breakdowns-form').length < 3);

  $(document).on('click', '.breakdown-form-remove', (e) => {
    e.target.closest('.breakdowns-form').remove();
    toggleAddFormButton('.breakdowns-form-add-wrapper', true);
  });
}


function addBreakdownForm() {
  const forms = document.querySelectorAll('.breakdowns-form');
  const formPrototype = forms[forms.length - 1];
  BreakdownFormContextRegistry.get(formPrototype.getAttribute('id')).destroy();

  const index = parseInt(formPrototype.getAttribute('data-index'));
  const cloned = formPrototype.cloneNode(true) as HTMLElement;
  cloned.setAttribute("data-index", `${index + 1}`);
  cloned.setAttribute('id', `breakdown-form-${index + 1}`);
  $(formPrototype).after(cloned);

  [formPrototype, cloned].forEach(el => BreakdownFormContextRegistry.addContext(el.getAttribute('id')));
  BreakdownFormContextRegistry.get(cloned.getAttribute('id')).reset();

  setToggleId(cloned, index + 1);``
  toggleAddFormButton('.breakdowns-form-add-wrapper', forms.length < 2);
}
