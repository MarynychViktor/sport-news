class HomePageBuilder
  def self.build
    builder = new
    yield builder if block_given?
    builder
  end

  def qweqwe

  end
  # def index
  #   @articles = Home::Article.resolve
  #   @breakdowns = Home::Breakdown.resolve
  #   @photo_of_the_day = Home::PhotoOfTheDay.instance_or_new
  #   @settings = Home::Setting.instance_or_new
  #   @default_category = Category.first
  # end
end