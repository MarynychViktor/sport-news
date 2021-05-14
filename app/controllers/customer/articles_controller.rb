module Customer
  class ArticlesController < ApplicationController
    def index
      @articles = Article.find_public_articles_by(search_params)

      @most_commented = @articles.most_commented(max: 3)
      @most_popular = @articles.most_popular(max: 3)

      @hero_articles = @articles.take(1)
      @other_articles = @articles.offset(1).take(4)
    end

    def show
      @article = Article.friendly.find(params[:id])
    end

    private

    def search_params
      params.permit(:category_id, :subcategory_id, :team_id).select { |k, v| v && !v.empty? }.to_hash
    end
  end
end
