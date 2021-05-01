import './form'

setupSubmitListeners();

function setupSubmitListeners() {
  $('.articles-save-button').on('click', () => {
    $('#new_article').submit();
  });
}
