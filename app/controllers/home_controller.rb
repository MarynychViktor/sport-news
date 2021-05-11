class HomeController < ApplicationController
  def index
    @articles = Home::Article.visible.map(&:article)
    @breakdowns = Home::Breakdown.resolve
    @photo_of_the_day = Home::PhotoOfTheDay.instance
    @settings = Home::Setting.instance
  end
end
