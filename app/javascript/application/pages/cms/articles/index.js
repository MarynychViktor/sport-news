import { createSelect } from '../../../helpers';

let subcategoryFilterSelect = null;
let teamFilterSelect = null;
let publishFilterSelect = null;

createSelect('#subcategory-filter', {
  allowEmptyOption: true,
  onChange(value) {
    if (value !== undefined) {
      teamFilterSelect.setValue('');
      const form = subcategoryFilterSelect.$input.closest('form');
      form.submit();
    }
  }
}).then(selectize => subcategoryFilterSelect = selectize);

createSelect('#team-filter', {
  allowEmptyOption: true,
  onChange(value) {
    if (value !== undefined) {
      const form = teamFilterSelect.$input.closest('form');
      form.submit();
    }
  }
}).then(selectize => teamFilterSelect = selectize);

createSelect('#published-filter', {
  allowEmptyOption: true,
  onChange(value) {
    if (value !== undefined) {
      const form = publishFilterSelect.$input.closest('form');
      form.submit();
    }
  }
}).then(selectize => publishFilterSelect = selectize);