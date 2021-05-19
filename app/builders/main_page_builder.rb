class MainPageBuilder
  attr_reader :main_page

  def self.build
    builder = new
    yield builder if block_given?
    builder.main_page
  end

  def initialize
    @main_page = Home::MainPage.new
  end

  def add_article(article)
    @main_page.articles << article
  end

  def add_breakdown(breakdown)
    @main_page.breakdowns << breakdown
  end

  def set_photo_of_the_day(photo)
    @main_page.photo_of_the_day = photo
  end

  def set_settings(settings)
    @main_page.settings = settings
  end
end
