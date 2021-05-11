import { ArticleFormContextRegistry } from "application/pages/cms/home/article-form-context";

document.querySelectorAll('.articles-form')
  .forEach(form => ArticleFormContextRegistry.addContext(form.getAttribute('id')));

document.querySelector('.article-form-add').addEventListener('click', addForm);

$(document).on('click', '.article-form-remove', (e) => {
  e.target.closest('.articles-form').remove();
  toggleAddFormButton(true);
});

function toggleAddFormButton(show: boolean) {
  const addLinkWrapper = document.querySelector('.articles-form-add-wrapper') as HTMLElement;
  if (show) {
    addLinkWrapper.style.display = 'block';
  } else if (addLinkWrapper.style.display !== 'none') {
    addLinkWrapper.style.display = 'none';
  }
}

function addForm() {
  const forms = document.querySelectorAll('.articles-form');
  const formPrototype = forms[forms.length - 1];
  ArticleFormContextRegistry.get(formPrototype.getAttribute('id')).destroy();

  const index = parseInt(formPrototype.getAttribute('data-index'));
  const cloned = formPrototype.cloneNode(true) as HTMLElement;
  cloned.setAttribute("data-index", `${index + 1}`);
  cloned.setAttribute('id', `article-form-${index + 1}`);
  $(formPrototype).after(cloned);

  [formPrototype, cloned].forEach(el => ArticleFormContextRegistry.addContext(el.getAttribute('id')));
  ArticleFormContextRegistry.get(cloned.getAttribute('id')).clear();

  toggleAddFormButton(forms.length < 4);
}
