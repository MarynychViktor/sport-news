import throttle from 'lodash.throttle';

export abstract class DocumentInfiniteScroll {
  private loading = false;
  private target = document.documentElement;

  constructor(private threshold = 0.7) {
    this.listenForScroll();
  }

  private listenForScroll() {
    const onScroll = throttle(() => {
      if (!this.hasMore()) {
        document.removeEventListener("scroll", onScroll);
        return;
      }

      if (!this.loading && this.thresholdReached()) {
        this.loading = true;
        this.loadMore().finally(() => this.loading = false);
      }
    }, 300);

    document.addEventListener('scroll', onScroll, { passive: true });
  }

  abstract hasMore(): boolean;
  abstract loadMore(): Promise<void>;

  private thresholdReached() {
    const { clientHeight, scrollTop, scrollHeight } = this.target;
    return (clientHeight + scrollTop) / scrollHeight >= this.threshold;
  }
}
