module Customer
  class ArticlesController < ApplicationController
    def index
      @most_commented = Article.most_commented(max: 3)
      @most_popular = Article.most_popular(max: 3)

      @hero_articles = Article.published.take(1)
      @other_articles = Article.published.offset(1).take(4)
      @article = Article.first
    end

    def show
      @article = Article.friendly.find(params[:id])
    end
  end
end
