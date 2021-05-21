module MainPages
  class PageBuilder
    attr_reader :main_page

    def self.build
      builder = new
      yield builder if block_given?
      builder.main_page
    end

    def initialize
      @main_page = Home::MainPage.new
    end

    def articles(*articles)
      articles.each do |article|
        @main_page.articles << case article
                               when Home::Article
                                 article
                               when Hash
                                 Home::Article.new(article)
                               else
                                 raise ArgumentError, 'Invalid article provided'
                               end
      end
    end

    def breakdowns(*breakdowns)
      breakdowns.each do |breakdown|
        @main_page.breakdowns << case breakdown
                                 when Home::Breakdown
                                   breakdown
                                 when Hash
                                   Home::Breakdown.new(breakdown)
                                 else
                                   raise ArgumentError, 'Invalid breakdown provided'
                                 end
      end
    end

    def photo_of_the_day(photo)
      @main_page.photo_of_the_day = photo
    end

    def settings(settings)
      @main_page.settings = settings
    end
  end
end