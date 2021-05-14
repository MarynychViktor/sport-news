module CMS
  class ArticlesController < ApplicationController
    before_action :find_category, :find_article

    def index
      query_builder = @category.articles.find_articles_by(search_params)
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
      query_builder = @category.articles.find_articles_by(search_params)
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
      params.require(:article).permit(:subcategory_id, :team_id, :picture, :caption, :alt, :location,
                                      :headline, :content, :display_comments)
    end

    def search_params
      output = %i[subcategory_id team_id published].each_with_object({}) { |(k, v), res| res[k] = v if v && !v.empty? }

      case output[:published]
      when '1'
        output[:published] = true
      when '0'
        output[:published] = false
      else
        output.delete(:published)
      end

      output
    end
  end
end
