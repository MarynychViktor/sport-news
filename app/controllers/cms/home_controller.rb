module CMS
  # TODO: complete refactoring
  class HomeController < ApplicationController
    layout 'cms'

    before_action :build_models, :validate_models, only: :create

    def index
      @articles = Home::Article.resolve
      @breakdowns = Home::Breakdown.resolve
      @photo_of_the_day = Home::PhotoOfTheDay.instance_or_new
      @settings = Home::Setting.instance_or_new
      @default_category = Category.first
    end

    def create
      ActiveRecord::Base.transaction do
        Home::Article.upsert_home_articles(@articles)
        Home::Breakdown.upsert_home_breakdowns(@breakdowns)
        @photo_of_the_day.save!
        @settings.save!
      end

      redirect_to cms_root_path
    end

    private

    def build_models
      @articles = Home::Article.build_from(page_params[:articles])
      @breakdowns = Home::Breakdown.build_from(page_params[:breakdowns])

      @photo_of_the_day = Home::PhotoOfTheDay.instance_or_new
      @photo_of_the_day.assign_attributes(page_params[:photo_of_the_day])

      @settings = Home::Setting.instance_or_new
      @settings.assign_attributes(page_params[:settings])
    end

    def validate_models
      if @articles.all?(&:valid?) &&
         @breakdowns.all?(&:valid?) &&
         @photo_of_the_day.valid? &&
         @settings.valid?

        return
      end

      @default_category = Category.first

      render :index
    end

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
