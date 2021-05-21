import debounce from 'lodash.debounce';

// TODO: add breadcrumb styles
export function setupSearchField() {
  const input = document.querySelector('#app-search input');
  if (!input) {
    return;
  }
  const onInput = debounce((event) => {
    const query = (event.target as HTMLInputElement).value;
    if (query) {
      searchArticles(query);
      const onClickOutside = (e) => {
        if (!e.target.closest('.h-search-wrapper')) {
          clearSuggestions();
          document.removeEventListener('click', onClickOutside);
        }
      }
      document.addEventListener('click', onClickOutside);
    } else {
      clearSuggestions();
    }
  }, 300);

  input.addEventListener('input', onInput);
  input.addEventListener('focus', onInput);
}

function searchArticles(query: string) {
  $.ajax({
    url: `/search?query=${query}`,
    dataType: 'script'
  });
}
function clearSuggestions() {
  $('.h-search-suggestions').empty()
}
