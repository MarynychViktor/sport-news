module Customer
  class ArticlesController < ApplicationController
    def index
      @most_commented = Article.most_commented(max: 3)
      @most_popular = Article.most_popular(max: 3)

      @articles = Article.from_query(search_params)
      @hero_articles = @articles.take(1)
      @other_articles = @articles.offset(1).take(4)
      @article = Article.first
    end

    def show
      @article = Article.friendly.find(params[:id])
    end

    private

    def search_params
      query = params.permit(:category_id, :subcategory_id, :team_id).select { |k, v| v && !v.empty? }
      { where: query, scopes: %i[published] }
    end
  end
end
