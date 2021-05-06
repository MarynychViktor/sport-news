module CMS
  class ArticlesController < ApplicationController
    before_action :find_category, :find_article

    def index
      @articles = paginate(@category.articles.where(search_params))
    end

    def page
      @articles = paginate(@category.articles.where(search_params))
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

    def search_params
      params.permit(:subcategory_id, :team_id, :published).select { |_, value| value && !value.empty? }
    end
  end
end