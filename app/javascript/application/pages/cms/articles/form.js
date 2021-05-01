import { createSelect } from '../../../helpers';

let teamSelectize = null;
let subcategorySelectize = null;
let teamOptions = [];
let subcategoryId = null;

parseTeamOptions();
initTeamSelect().then(() => initSubcategorySelect());
renderRichTextEditor('#content-field');


function parseTeamOptions() {
    teamOptions = JSON.parse($('#article-team-select').attr('data-teams'));
  }

function initTeamSelect() {
    return new Promise(resolve => {
      createSelect('#article-team-select', {
        valueField: 'value',
        labelField: 'label',
        allowEmptyOption: true,
        options: [],
        onInitialize() {
          teamSelectize = this;
          resolve();
        }
      });
    })
  }

function initSubcategorySelect() {
    createSelect('#article-subcategory-select', {
      allowEmptyOption: true,
      onInitialize() {
        const value = this.getValue();
        if (value) {
          subcategoryId = parseInt(value);
          renderTeamSelectForSubcategory();
        }
      },
      onChange: (value) => {
        if (!value) {
          subcategoryId = null;
          teamSelectize.clear();
          teamSelectize.disable();
          return;
        }
        subcategoryId = parseInt(value);
        renderTeamSelectForSubcategory();
      }
    })
  }

function renderTeamSelectForSubcategory() {
    teamSelectize.enable();
    const teams = teamOptions.find(opt => opt[0] === subcategoryId)[1]
    teamSelectize.clear();
    teamSelectize.clearOptions();
    teamSelectize.addOption(teams.map(t => ({label: t[0], value: t[1]})))
    teamSelectize.refreshOptions(false)
  }

function renderRichTextEditor(selector) {
    const field  = document.querySelector('#article_content');
    ClassicEditor
      .create(document.querySelector(selector), {
        toolbar: ['heading1', 'heading2', 'paragraph', '|', 'bold', 'italic', 'underline', '|', 'bulletedList', 'numberedList', '|', 'alignment:left', 'alignment:center', 'alignment:right'],
      })
      .then((editor) => {
        // clearErrorsOnReachTextField();
        editor.setData(field.value);
        editor.model.document.on( 'change:data', () => {
          field.value = editor.getData();
        });
      });
  }