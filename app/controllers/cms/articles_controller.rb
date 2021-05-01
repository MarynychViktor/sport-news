module CMS
  class ArticlesController < ApplicationController
    before_action :find_category, :find_article

    def index
      @subcategories = @category.subcategories
      @teams = @category.find_teams(subcategory_id: params[:subcategory])
      @articles = @category.find_articles(
        subcategory_id: params[:subcategory],
        team_id: params[:team],
        published: params[:published]
      )
    end

    def new
      @article = Article.new
      setup_options
    end

    def create
      @article = @category.articles.create(article_params)

      if @article.valid?
        redirect_to cms_category_articles_url(@category)
      else
        setup_options
        render :new
      end
    end

    def edit
      setup_options
    end

    def update
      @article.update(article_params)

      if @article.valid?
        redirect_to cms_category_articles_url(@category)
      else
        setup_options
        render :edit
      end
    end

    private

    def setup_options
      subcategories = @category.subcategories
      @subcategories_options = subcategories.map { |s| [s.name, s.id] }
      @teams_options = subcategories.map { |s| [s.id, s.teams.map { |t| [t.name, t.id] }] }
    end

    def find_article
      @article = Article.friendly.find(params[:id]) if params[:id]
    end

    def find_category
      @category = Category.includes(subcategories: :teams).find(params[:category_id]) if params[:category_id]
    end

    def article_params
      params.require(:article).permit(:conference, :subcategory_id, :team_id, :picture, :caption, :alt, :location, :headline, :content, :display_comments)
    end
  end
end