const commentsInput = document.querySelector('#comment-input') as HTMLElement;
const commentField = document.querySelector('#content-field') as HTMLInputElement;
const commentsActions = document.querySelector('.comments-input-actions') as HTMLElement;

let previousValue = '';

const cancelButton = document.querySelector('.comments-form-cancel');
cancelButton.addEventListener('click', (e) => {
  e.preventDefault();
  commentsInput.innerText = '';
});
