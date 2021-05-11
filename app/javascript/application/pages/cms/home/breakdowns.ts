import { BreakdownFormContextRegistry } from "application/pages/cms/home/breakdown-form-context";

document.querySelectorAll('.breakdowns-form')
  .forEach(form => BreakdownFormContextRegistry.addContext(form.getAttribute('id')));

document.querySelector('.breakdown-form-add').addEventListener('click', addForm);

$(document).on('click', '.breakdown-form-remove', (e) => {
  console.log('e.target.closest(\'.breakdowns-form\')', e.target.closest('.breakdowns-form'));
  e.target.closest('.breakdowns-form').remove();
  toggleAddFormButton(true);
});

function toggleAddFormButton(show: boolean) {
  const addLinkWrapper = document.querySelector('.breakdowns-form-add-wrapper') as HTMLElement;
  if (show) {
    addLinkWrapper.style.display = 'block';
  } else if (addLinkWrapper.style.display !== 'none') {
    addLinkWrapper.style.display = 'none';
  }
}

function addForm() {
  const forms = document.querySelectorAll('.breakdowns-form');
  const formPrototype = forms[forms.length - 1];
  BreakdownFormContextRegistry.get(formPrototype.getAttribute('id')).destroy();

  const index = parseInt(formPrototype.getAttribute('data-index'));
  const cloned = formPrototype.cloneNode(true) as HTMLElement;
  cloned.setAttribute("data-index", `${index + 1}`);
  cloned.setAttribute('id', `breakdown-form-${index + 1}`);
  $(formPrototype).after(cloned);

  [formPrototype, cloned].forEach(el => BreakdownFormContextRegistry.addContext(el.getAttribute('id')));
  BreakdownFormContextRegistry.get(cloned.getAttribute('id')).clear();

  toggleAddFormButton(forms.length < 2);
}
