class HomeController < ApplicationController
  def index
    @breakdowns = Home::Breakdown.visible
    @main_page = MainPages::ResolvePageService.call.page

    @articles = @main_page.articles.select(&:show?).map(&:article)
    @breakdowns = @main_page.breakdowns.select(&:show?)

    @photo_of_the_day = @main_page.photo_of_the_day
    @settings = @main_page.settings

    @highlighted_articles = Article.published.trending

    @popular_articles = Article.most_popular if @settings&.show_popular_articles
    @commented_articles = Articles::FindMostCommentedQuery.call if @settings&.show_commented_articles
  end
end
