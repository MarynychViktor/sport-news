module CMS
  class ArticlesController < ApplicationController
    before_action :find_category

    def new
      @article = Article.new
      render_new_form
    end

    def create
      @article = Article.create(article_params)

      if @article.valid?
        redirect_to '/'
      else
        render_new_form
      end
    end

    private

    def render_new_form
      subcategories = @category.subcategories
      @subcategories_options = subcategories.map { |s| [s.name, s.id] }
      @teams_options = subcategories.map { |s| [s.id, s.teams.map { |t| [t.name, t.id] }] }

      render :new
    end

    def find_category
      @category = Category.includes(subcategories: :teams).find(params[:category_id]) if params[:category_id]
    end

    def article_params
      params.require(:article).permit(:conference, :team, :caption, :alt, :location, :headline, :content, :display_comments)
    end
  end
end