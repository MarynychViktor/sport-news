import debounce from 'lodash.debounce';

// TODO: add breadcrumb styles
export function setupSearchField() {
  const input = document.querySelector('#app-search input');
  const onInput = debounce((event) => {
    const query = (event.target as HTMLInputElement).value;
    if (query) {
      searchArticles(query);
    } else {
      clearSuggestions();
    }
  }, 300);

  input.addEventListener('input', onInput);
  input.addEventListener('focus', onInput);
  input.addEventListener('blur', clearSuggestions);
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
