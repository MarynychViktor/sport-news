module MainPages
  class ResolvePageService
    include Callable
    include Result::Helpers

    def initialize(prefill_on_empty: false)
      @prefill_on_empty = prefill_on_empty
    end

    def call
      fetch_resources
      process_resources
      @main_page = MainPages::PageBuilder.build do |builder|
        builder.articles(*@articles)
        builder.breakdowns(*@breakdowns)
        builder.photo_of_the_day(@photo)
        builder.settings(@setting)
      end
      success(@main_page)
    end

    private

    def fetch_resources
      @articles = Home::Article.all
      @breakdowns = Home::Breakdown.all
      @photo = Home::PhotoOfTheDay.instance
      @setting = Home::Setting.instance
    end

    def process_resources
      if @prefill_on_empty
        @articles = [Home::Article.new] if @articles.empty?
        @breakdowns = [Home::Article.new] if @breakdowns.empty?
      else
        @photo = nil unless @photo.persisted?
        @setting = nil unless @setting.persisted?
      end
    end
  end
end
