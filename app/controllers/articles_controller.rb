class ArticlesController < ApplicationController
  def index
    @articles = Articles::FindQuery.call(search_params, Article.visible.published)
    @most_commented = Articles::FindMostCommentedQuery.call(params: search_params)

    # Since articles current dont have popularity tracking functionality
    # use `stub` articles instead
    # TODO: add logic to resolve most popular articles
    # TODO: remove magic constants ref https://github.com/MarinichViktor/sport-news/pull/4#discussion_r636073537
    @most_popular = @articles.most_popular(max: 3)
    @hero_articles = @articles.take(1)
    @other_articles = @articles.offset(1).take(4)
  end

  def show
    @article = Article.friendly.find(params[:id])
    authorize @article, :show?
  end

  private

  def search_params
    params.permit(:category_id, :subcategory_id, :team_id).compact_blank
  end
end
