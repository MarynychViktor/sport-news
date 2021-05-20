class HomeController < ApplicationController
  # TODO: refactor
  def index
    @breakdowns = Home::Breakdown.visible
    @main_page = Home::ResolveMainPage.call(new_on_empty: false).result

    @articles = @main_page.articles.select(&:show?).map(&:article)
    @breakdowns = @main_page.breakdowns.select(&:show?)

    @photo_of_the_day = @main_page.photo_of_the_day
    @settings = @main_page.settings

    # TODO: remove magic constants ref https://github.com/MarinichViktor/sport-news/pull/4#discussion_r636073537
    @highlighted_articles = Article.published.offset(5).take(4)

    @popular_articles = Article.most_popular if @settings&.show_popular_articles
    @commented_articles = Articles::FindMostCommentedQuery.call if @settings&.show_commented_articles
  end
end
