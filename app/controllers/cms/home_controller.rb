module CMS
  class HomeController < ApplicationController
    layout 'cms'

    def index
      @main_page = Home::ResolveMainPage.call.result
      @default_category = Category.first
    end

    def create
      response = Home::PersistMainPage.call(page_params[:articles],
                                            page_params[:breakdowns],
                                            page_params[:photo_of_the_day],
                                            page_params[:settings])

      redirect_to cms_root_path and return if response.success?

      @main_page = response.result
      @default_category = Category.first

      render :index
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
