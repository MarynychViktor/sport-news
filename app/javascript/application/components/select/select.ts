import 'selectize';
import 'select2/dist/js/select2.full';
import { BehaviorSubject, ReplaySubject, Subject } from "rxjs";

const DEFAULT_CONFIG = {
  dropdownCssClass: 'app-select2-dropdown',
  selectionCssClass: 'app-select2-selection',
  minimumResultsForSearch: Infinity,
};

export class Select {
  public selectize: any;
  private initSource = new BehaviorSubject<any>(undefined);
  initialized$ = this.initSource.asObservable();

  private changeSource = new ReplaySubject<string>(1);
  changed$ = this.changeSource.asObservable();

  private focusSource = new Subject<void>();
  focused$ = this.focusSource.asObservable();

  constructor(private selector, private options: any = {}) {
    this.init();
  }

  private init() {
    const config = this.prepareConfig();
    this.getSelect().select2(config);
    this.initSource.next(this.getValue());
    this.setUpListeners();
  }

  private setUpListeners() {
    this.getSelect().on('change', () => this.onChange(this.getValue()));
    this.getSelect().on('select2:opening', () => this.onFocus());
  }

  private getSelect() {
    return $(this.selector) as any;
  }

  getValue() {
    return this.getSelect().val();
  }

  setValue(value) {
    return this.getSelect().val(value);
  }

  clear() {
    this.getSelect().empty().trigger('change');
    this.clearSimpleFormErrors();
  }

  disableWithClear() {
    this.getSelect().empty().trigger('change');
    this.getSelect().prop("disabled", true);
  }

  disable() {
    this.getSelect().prop("disabled", true);
  }
  enable() {
    this.getSelect().prop("disabled", false);
  }

  destroy() {
    this.getSelect().select2('destroy');
  }

  private onFocus() {
    this.focusSource.next();
  }

  private onChange(value) {
    if (value) {
      this.clearSimpleFormErrors()
    }

    this.changeSource.next(value);
  }

  clearSimpleFormErrors () {
    const target = document.querySelector(this.selector);
    const fieldWrapper = target.closest('.field_with_errors');

    if (fieldWrapper) {
      fieldWrapper.classList.remove('field_with_errors');
      const error = fieldWrapper.querySelector('.app-input-error');

      if (error) {
        error.remove();
      }

      fieldWrapper.querySelector('select').removeAttribute('aria-invalid');
    }
  }

  private prepareConfig() {
    const {ajax} = this.options;

    if (ajax) {
      if (!ajax.dataType) {
        ajax.dataType = 'json';
      }

      if (!ajax.processResults) {
        ajax.processResults = function (result) {
          return {
            results: result.data.map(({id, name}) => ({id, text: name})),
            pagination: {
              more: !result.last_page
            }
          };
        }
      }
    }

    return {...DEFAULT_CONFIG, ...this.options};
  }
}