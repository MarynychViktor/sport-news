module Home
  class ResolveMainPage
    include Callable
    include Result::Helpers

    def initialize(new_on_empty: true)
      @new_on_empty = new_on_empty
    end

    def call
      build_main_page
      success(@main_page)
    end

    private

    def build_main_page
      @main_page = MainPageBuilder.build do |builder|
        resolve_articles.each { |article| builder.add_article(article) }
        resolve_breakdowns.each { |article| builder.add_breakdown(article) }
        instance_resolver = @new_on_empty ? :first_or_initialize : :first
        builder.set_photo_of_the_day(Home::PhotoOfTheDay.public_send(instance_resolver))
        builder.set_settings(Home::Setting.public_send(instance_resolver))
      end
    end

    def resolve_articles
      articles = Home::Article.all
      return articles unless articles.empty?

      @new_on_empty ? [Home::Article.new] : []
    end

    def resolve_breakdowns
      breakdowns = Home::Breakdown.all
      return breakdowns unless breakdowns.empty?

      @new_on_empty ? [Home::Breakdown.new] : []
    end
  end
end
