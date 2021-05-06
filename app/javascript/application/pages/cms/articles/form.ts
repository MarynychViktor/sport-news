import { Select } from "application/components/select";
declare const ClassicEditor: any;

const categoryId = (document.querySelector('[name="category_id"]') as HTMLInputElement).value;

renderRichTextEditor('#content-field');
setupSubmitListeners();


const subCategorySelect = new Select('#article-subcategory-select', {
  placeholder: 'Select a subcategory',
  ajax: {
      url: `/cms/categories/${categoryId}/subcategories`,
  },
});

const teamSelect = new Select('#article-team-select', {
  placeholder: 'Select a team',
  ajax: {
    url: function () {
      const subcategory = subCategorySelect.getValue();

      if (subcategory) {
        return `/cms/subcategories/${subcategory}/teams`;
      }

      return '/cms/teams';
    },
  },
});
const locationSelect = new Select('#article_location');
subCategorySelect.changed$.subscribe(() => teamSelect.clear());

function renderRichTextEditor(selector) {
  const field  = document.querySelector('#article_content') as HTMLInputElement;
  ClassicEditor
    .create(document.querySelector(selector), {
      toolbar: ['heading1', 'heading2', 'paragraph', '|', 'bold', 'italic', 'underline', '|', 'bulletedList', 'numberedList', '|', 'alignment:left', 'alignment:center', 'alignment:right'],
    })
    .then((editor) => {
      editor.setData(field.value);
      editor.model.document.on( 'change:data', () => {
        field.value = editor.getData();
      });
    });
}

function setupSubmitListeners() {
  $('.articles-save-button').on('click', () => {
    // const input = $('#article_picture.untouched');
    //
    // if (input) {
    //   input.remove()
    // }

    $('.articles-form form').submit();
  });
}