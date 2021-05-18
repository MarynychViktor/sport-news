const {controller, action} = window.AppContext.request;

if (!['index', 'show'].includes(action)) {
  import('./articles1/form');
}

if ('index' === action) {
  import('./articles1/index');
}