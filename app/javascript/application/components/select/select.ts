import 'selectize';
import 'select2/dist/js/select2.full';
import { BehaviorSubject, Subject } from "rxjs";

const DEFAULT_CONFIG = {
    dropdownCssClass: 'app-select2-dropdown',
    selectionCssClass: 'app-select2-selection',
    minimumResultsForSearch: Infinity,
};

export class Select {

    public selectize: any;
    private initSource = new BehaviorSubject<void>(undefined);
    initialized$ = this.initSource.asObservable();

    private changeSource = new BehaviorSubject<string>(null);
    changed$ = this.changeSource.asObservable();

    private focusSource = new Subject<void>();
    focused$ = this.focusSource.asObservable();

    constructor(private selector, private options: any = {}) {
        this.init();
    }

    private init() {
        const config = this.prepareConfig();
        this.getSelect().select2(config);
        this.setUpListeners();

        // const config = this.prepareSelectizeConfig();
        // const selectize = ($(this.selector) as any).select2({
        //     dropdownCssClass: 'app-select2-dropdown',
        //     selectionCssClass: 'app-select2-selection',
        //     minimumResultsForSearch: -1,
        //     ajax: {
        //         url: '/cms/categories/5/subcategories',
        //         dataType: 'json',
        //         processResults: function (result, params) {
        //             console.log('data, params', result, params);
        //             params.page = params.page || 1;
        //             i++;
        //
        //             return {
        //                 results: result.data.map(({id, name}) => ({id, text: name})),
        //                 pagination: {
        //                     more: !result.last_page
        //                 }
        //             };
        //         }
        //     },
        //
        // });
        // ($(this.selector) as any).on('change', (e) => {
        //     console.log('select change', e, $(this.selector).val());
        // });
        // this.selectize = selectize[0].selectize;
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

    disable() {
        this.getSelect().prop("disabled", true);
    }
    enable() {
        this.getSelect().prop("disabled", false);
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