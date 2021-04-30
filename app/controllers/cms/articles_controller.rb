module CMS
  class ArticlesController < ApplicationController
    def new
      @article = Article.new
      @subcategories = Subcategory.all.map { |s| [s.name, s.id] }
      @teams = Team.all.map { |s| [s.name, s.id] }
    end

    def create
      @article = Article.create(article_params)

      if @article.valid?
        redirect_to '/'
      else
        render :new
      end
    end

    private

    def article_params
      params.require(:article).permit(:conference, :team, :caption, :alt, :location, :headline, :content, :display_comments)
    end
  end
end