const {action} = window.AppContext.request;

if ('show' === action) {
  import('./info_architecture/show');
}