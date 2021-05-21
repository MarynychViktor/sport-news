module CMS::Articles
  class TranslationsController < CMS::ApplicationController
    before_action :find_article_and_category
    around_action :apply_locale_context

    def edit
      # @locale = params[:id].to_sym
      # @article = Article.find(params[:article_id])
      # @category = @article.category
    end

    def update
      if @article.update(article_params)
        return redirect_to edit_cms_category_article_path(@category, @article)
      else
        render :edit
      # @locale = params[:id].to_sym
      # @article = Article.find(params[:article_id])
      # @category = @article.category
      #
      end
    end

    private

    def find_article_and_category
      @locale = params[:id]
      @article = Article.friendly.find(params[:article_id])
      @category = @article.category
    end

    def apply_locale_context(&action)
      Mobility.with_locale(params[:id].to_sym, &action)
    end

    def article_params
      params.require(:article).permit(:headline, :alt, :caption, :content)
    end
  end
end
