module CMS
  class ArticlesController < ApplicationController
    before_action :find_category
    before_action :find_article, only: %i[edit update publish unpublish destroy]

    def index
      result = ::Articles::FindQuery.call(search_params, @category.articles)
      @articles = paginate(result)

      respond_to do |format|
        format.html do
          @subcategory = Subcategory.find(params[:subcategory_id]) if params[:subcategory_id]
          @team = Team.find(params[:team_id]) if params[:team_id]
        end

        format.json { render json: @articles }
      end
    end

    def page
      result = ::Articles::FindQuery.call(search_params, @category.articles)
      @articles = paginate(result)
    end

    def new
      @article = Article.new
    end

    def create
      response = ::Articles::CreateService.call(@category, article_params)
      @article = response.article

      if response.success?
        redirect_to cms_category_articles_url(@category)
      else
        render :new
      end
    end

    def update
      response = ::Articles::UpdateService.call(@category, @article, article_params)
      @article = response.article

      if response.success?
        redirect_to cms_category_articles_url(@category)
      else
        render :edit
      end
    end

    def publish
      @article.publish
      redirect_to cms_category_articles_url(@category)
    end

    def unpublish
      @article.unpublish
      redirect_to cms_category_articles_url(@category)
    end

    def destroy
      @article.destroy
      redirect_to cms_category_articles_url(@category)
    end

    private

    def find_category
      @category = Category.includes(subcategories: :teams).find(params[:category_id])
    end

    def find_article
      @article = Article.friendly.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:subcategory_id, :team_id, :picture, :caption, :alt, :location,
                                      :headline, :content, :display_comments)
    end

    # TODO: review
    def search_params
      search_query = params.permit(:subcategory_id, :team_id, :published)
                           .select {|k, v| v && !v.empty? }
      published_param = search_query.delete(:published)


      return search_query unless published_param


      case published_param
      when '1'
        search_query[:published?] = :published
      when '0'
        search_query[:published?] = :unpublished
      end

      search_query
    end
  end
end
