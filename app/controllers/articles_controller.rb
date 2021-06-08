class ArticlesController < ApplicationController
  def index
    @articles = Articles::FindQuery.call(search_params, Article.visible.published)
    @most_commented = Articles::FindMostCommentedQuery.call(params: search_params)

    @most_popular = @articles.most_popular
    @hero_articles = @articles.hero
    @other_articles = @articles.trending
  end

  def show
    @article = Article.friendly.find(params[:id])
    authorize @article, :show?
    render :show
  end

  private

  def search_params
    params.permit(:category_id, :subcategory_id, :team_id).compact_blank
  end
end
