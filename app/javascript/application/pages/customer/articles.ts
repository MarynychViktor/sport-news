const commentsInput = document.querySelector('#comment-input') as HTMLElement;
const commentField = document.querySelector('#content-field') as HTMLInputElement;
const commentsActions = document.querySelector('.comments-input-actions') as HTMLElement;

let previousValue = '';
// commentsInput.addEventListener('input', (e) => {
//   const value = (e.target as any).innerText;
//
//   if (previousValue && !value) {
//     commentsActions.style.display = 'none';
//   } else if (!previousValue && value) {
//     commentsActions.style.display = 'flex';
//   }
//
//   commentField.value = value;
//   previousValue = value;
// });

const cancelButton = document.querySelector('.comments-form-cancel');
cancelButton.addEventListener('click', (e) => {
  e.preventDefault();
  commentsInput.innerText = '';
});
