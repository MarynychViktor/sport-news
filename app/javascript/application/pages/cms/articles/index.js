import { createSelect } from '../../../helpers';

let teamFilterSelect = null;

createSelect('#subcategory-filter', {
  allowEmptyOption: true,
  onChange(value) {
    if (value !== undefined) {
      if (teamFilterSelect) {
        teamFilterSelect.setValue('');
      }
      const form = this.$input.closest('form');
      form.submit();
    }
  }
});

createSelect('#team-filter', {
  allowEmptyOption: true,
  onChange(value) {
    if (value !== undefined) {
      const form = this.$input.closest('form');
      form.submit();
    }
  }
}).then(selectize => teamFilterSelect = selectize);

createSelect('#published-filter', {
  allowEmptyOption: true,
  onChange(value) {
    if (value !== undefined) {
      const form = this.$input.closest('form');
      form.submit();
    }
  }
});
