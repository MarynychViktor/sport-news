const [_, action] = window.controllerContext;

if (!['index', 'show'].includes(action)) {
  import('./articles/form');
}

if ('index' === action) {
  import('./articles/index');
}