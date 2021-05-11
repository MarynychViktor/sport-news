import 'selectize';
import 'select2/dist/js/select2.full';
import { BehaviorSubject, ReplaySubject, Subject } from "rxjs";
import { buffer } from "rxjs/internal/operators";

const DEFAULT_CONFIG = {
  dropdownCssClass: 'app-select2-dropdown',
  selectionCssClass: 'app-select2-selection',
  minimumResultsForSearch: Infinity,
};

export class Select {
  public selectize: any;
  private initSource = new BehaviorSubject<void>(undefined);
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
    // this.changeSource.next(this.getValue());
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
    this.changeSource.next(value);
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