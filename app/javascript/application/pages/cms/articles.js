const {action} = window.AppContext.request;

if (['new', 'edit', 'create', 'update'].includes(action)) {
  import('./articles/form');
}

if ('index' === action) {
  import('./articles/index');
}