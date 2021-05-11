class HomeController < ApplicationController
  def index
    @articles = Home::Article.visible.map(&:article)
    @breakdowns = Home::Breakdown.visible
    @photo_of_the_day = Home::PhotoOfTheDay.instance
    @settings = Home::Setting.instance

    @popular_articles = Article.most_popular if @settings.show_popular_articles
    @commented_articles = Article.most_commented if @settings.show_commented_articles
  end
end
