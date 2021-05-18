const {controller, action} = window.AppContext.request;

if ('show' === action) {
  import('./info_architecture1/show');
}