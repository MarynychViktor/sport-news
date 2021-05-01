import './form'

setupSubmitListeners();

function setupSubmitListeners() {
  $('.articles-save-button').on('click', () => {
    console.log('clicked')
    const input = $('#article_picture.untouched');

    if (input) {
      input.remove()
    }

    $('.edit_article').submit();
  });
}
