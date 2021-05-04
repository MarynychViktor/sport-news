const [_, action] = window.controllerContext;

if ('show' === action) {
  import('./info_architecture/show');
}