import { clearErrorsOnReachTextField } from '../../../application/components/form';
import { createSelectize } from '../../../application/components/select';

export class ArticlePage {
    teamSelectize = null;
    subcategorySelectize = null;
    teamOptions = [];
    subcategoryId = null;

    static init() {
        if ('Articles' === window.resource) {
            const page = new ArticlePage();
            page.onInit();
            window.ArticlePage = page;
        }
    }

    onInit() {
        this.parseTeamOptions();
        this.initTeamSelect()
          .then(() => this.initSubcategorySelect());
        this.renderRichTextEditor('#content-field');
        this.setupSubmitListeners();
    }

    parseTeamOptions() {
        this.teamOptions = JSON.parse($('#article-team-select').attr('data-teams'));
    }

    initTeamSelect() {
        return new Promise(resolve => {
            const self = this;
            createSelectize('#article-team-select', {
                valueField: 'value',
                labelField: 'label',
                options: [],
                onInitialize() {
                    self.teamSelectize = this;
                    resolve();
                }
            });
        })
    }

    initSubcategorySelect() {
        const self = this;
        createSelectize('#article-subcategory-select', {
            onInitialize() {
                self.subcategorySelectize = this;
                const value = this.getValue();
                if (value) {
                    self.subcategoryId = parseInt(value);
                    self.renderTeamSelectForSubcategory();
                }
            },
            onChange: (value) => {
                if (!value) {
                    this.subcategoryId = null;
                    this.teamSelectize.clear();
                    this.teamSelectize.disable();
                    return;
                }
                this.subcategoryId = parseInt(value);
                this.renderTeamSelectForSubcategory();
            }
        })
    }

    renderTeamSelectForSubcategory() {
        this.teamSelectize.enable();
        const teams = this.teamOptions.find(opt => opt[0] === this.subcategoryId)[1]
        this.teamSelectize.clear();
        this.teamSelectize.clearOptions();
        this.teamSelectize.addOption(teams.map(t => ({label: t[0], value: t[1]})))
        this.teamSelectize.refreshOptions(false)
    }

    renderRichTextEditor(selector) {
        ClassicEditor
          .create(document.querySelector(selector), {
              toolbar: ['heading1', 'heading2', 'paragraph', '|', 'bold', 'italic', 'underline', '|', 'bulletedList', 'numberedList', '|', 'alignment:left', 'alignment:center', 'alignment:right'],
          })
          .then(() => clearErrorsOnReachTextField())
    }

    setupSubmitListeners() {
        $('.articles-save-button').on('click', () => {
            $('#new_article').submit();
        });
    }
}
