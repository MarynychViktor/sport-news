import { parse, stringify } from 'query-string';
import { DocumentInfiniteScroll } from "application/components/infinite-scroll/infinite-scroll";

declare const _context: {category: any, last_page: boolean};

class ArticlesInfiniteScroll extends DocumentInfiniteScroll {
  private page = 2;

  hasMore(): boolean {
    const {last_page} = _context;
    return !last_page;
  }

  loadMore(): Promise<void> {
    return new Promise((resolve) => {
      const queryParams = parse(window.location.search);
      queryParams.page = this.page;
      this.page++;

      $.ajax({
        url: `/cms/categories/1/articles/page?${stringify(queryParams)}`,
        dataType: 'script'
      })
        .done(() => resolve(undefined));
    })
  }
}

new ArticlesInfiniteScroll();
