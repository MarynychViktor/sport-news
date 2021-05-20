// @ts-ignore
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

let locationSelectize = null;
const articleSelect = ($('#article_location') as any).selectize({
  valueField: 'place_id',
  labelField: 'description',
  searchField: 'description',
  create: false,
  options: [],
  onLoad: function () {
    locationSelectize.open();
  },
  load: (query, callback) => {
    if (!query.length) {
      callback();
    }
    fetch(`/cms/places?query=${query}`)
      .then(res => res.json())
      .then(res => {
          locationSelectize.clearOptions();
          callback(res);
        }
      );
  }
});
locationSelectize = articleSelect[0].selectize;

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
    $('.articles-form form').submit();
  });
}