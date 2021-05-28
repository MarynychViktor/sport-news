module CMS
  class HomeController < ApplicationController
    layout 'cms'

    def index
      @main_page = MainPages::ResolvePageService.call(prefill_on_empty: true).page
      @default_category = Category.first
    end

    def create
      @main_page = MainPages::PageFromParamsFactory.call(page_params[:articles],
                                                         page_params[:breakdowns],
                                                         page_params[:photo_of_the_day],
                                                         page_params[:settings])

      if @main_page.save
        redirect_to cms_root_path
      else
        @default_category = Category.first

        render :index
      end
    end

    private

    def page_params
      params.require(:main_page).permit(
        articles: %i[category_id subcategory_id team_id article_id show],
        breakdowns: %i[category_id subcategory_id team_id show],
        photo_of_the_day: %i[image alt title description author show],
        settings: %i[show_popular_articles show_commented_articles]
      )
    end
  end
end
