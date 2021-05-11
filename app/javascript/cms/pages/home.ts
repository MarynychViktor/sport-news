console.log('123123');
document.querySelectorAll('.article-form-remove').forEach(button => {
  button.addEventListener('click', () => {
    const id = button.getAttribute('data-form-id');
    console.log('id is', id);
  });
});
