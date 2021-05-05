import { parse, stringify } from 'query-string';
declare const _context: {category: any, last_page: boolean};

const threshold = 0.7;

document.addEventListener('scroll', onScroll, { passive: true });

let loading = false;
function onScroll(event) {
  if (loading) {
    console.log('skip because loading');
  }

  if (!loading && thresholdReached()) {
    console.log('** start loading');
    loading = true;
    loadMoreArticles().finally(() => loading = false);
  }
}

function thresholdReached() {
  const { clientHeight, scrollTop, scrollHeight } = document.documentElement;
  return (clientHeight + scrollTop) / scrollHeight >= threshold;
}

let page = 2;


function loadMoreArticles() {
  return new Promise((resolve) => {
    const {last_page} = _context;
    if (last_page) {
      console.log('finished loading');
      document.removeEventListener('scroll', onScroll);
      return resolve(undefined);
    }

    const queryParams = parse(window.location.search);
    queryParams.page = page;
    page++;

    $.ajax({
      url: `/cms/categories/1/articles/page?${stringify(queryParams)}`,
      dataType: 'script'
    })
      .done(() => resolve(undefined));
  })
}