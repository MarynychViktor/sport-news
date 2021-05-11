module CMS
  class ArticlesController < ApplicationController
    before_action :find_category, :find_article

    def index
      query_builder = @category.articles.search(search_query)
      @articles = paginate(query_builder)

      respond_to do |format|
        format.html do
          @subcategory = Subcategory.find(params[:subcategory_id]) if params[:subcategory_id]
          @team = Team.find(params[:team_id]) if params[:team_id]
        end
        format.json { render json: @articles }
      end
    end

    def page
      query_builder = @category.articles.search(search_query)
      @articles = paginate(query_builder)
    end

    def new
      @article = Article.new
    end

    def create
      @article = @category.articles.create(article_params)

      if @article.valid?
        redirect_to cms_category_articles_url(@category)
      else
        render :new
      end
    end

    def update
      @article.update(article_params)

      if @article.valid?
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

    def find_article
      @article = Article.friendly.find(params[:id]) if params[:id]
    end

    def find_category
      @category = Category.includes(subcategories: :teams).find(params[:category_id]) if params[:category_id]
    end

    def article_params
      params.require(:article).permit(:conference, :subcategory_id, :team_id, :picture, :caption, :alt, :location,
                                      :headline, :content, :display_comments)
    end

    def search_query
      search_query = { where: search_params.slice(:subcategory_id, :team_id), scopes: [] }

      case search_params[:published]
      when '1'
        search_query[:scopes] << :published
      when '0'
        search_query[:scopes] << :unpublished
      end

      search_query
    end

    def search_params
      %i[subcategory_id team_id published].each_with_object({}) do |next_key, output|
        param = params[next_key]
        output[next_key] = param if param && !param.empty?
      end
    end
  end
end