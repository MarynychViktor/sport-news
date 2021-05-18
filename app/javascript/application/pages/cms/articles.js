const {controller, action} = window.AppContext.request;

console.log('action ***', action);
if (['new', 'edit', 'create', 'update'].includes(action)) {
  import('./articles/form');
}

if ('index' === action) {
  import('./articles/index');
}