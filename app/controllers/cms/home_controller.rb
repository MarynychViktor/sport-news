module CMS
  class HomeController < ApplicationController
    layout 'cms'

    def index
      @articles = Home::Article.all.to_a
      @articles << Home::Article.new if @articles.empty?

      @breakdowns = Home::Breakdown.all.to_a
      @breakdowns << Home::Breakdown.new if @breakdowns.empty?

      @photo_of_the_day = Home::PhotoOfTheDay.first_or_initialize
      @settings = Home::Setting.first_or_initialize
    end

    def store
      articles_from_params
      breakdowns_from_params
      photo_of_the_day_params
      settings

      if @articles.all?(&:valid?) && @breakdowns.all?(&:valid?) && @photo_of_the_day.valid? && @settings.valid?
        ActiveRecord::Base.transaction do
          @articles.each(&:save!)
          Home::Article.unscoped.where.not(id: @articles.map(&:id)).destroy_all

          @breakdowns.each(&:save!)
          Home::Breakdown.unscoped.where.not(id: @breakdowns.map(&:id)).destroy_all

          @photo_of_the_day.save!
        end

        redirect_to '/cms' and return
      end

      binding.pry

      render :index
    end

    private

    def articles_from_params
      @articles = page_params[:articles].map do |attrs|
        attrs[:show] ||= false
        article = Article.find_by_id(attrs[:article_id])
        home_article = Home::Article.find_or_initialize_by(article: article)
        attrs.each { |k, v| home_article.send("#{k}=", v) }
        home_article
      end
    end

    def breakdowns_from_params
      @breakdowns = page_params[:breakdowns].map do |attrs|
        breakdown = Home::Breakdown.find_or_initialize_by(attrs.except(:show))
        breakdown.show = attrs[:show] || false
        breakdown
      end
    end

    def photo_of_the_day_params
      @photo_of_the_day = Home::PhotoOfTheDay.first_or_initialize
      params[:photo_of_the_day].each { |k, v| @photo_of_the_day.send("#{k}=", v) }
    end

    def settings
      @settings = Home::Setting.first_or_initialize
      params[:settings].each { |k, v| @settings.send("#{k}=", v) }
    end

    def page_params
      params.require(:main_page).permit(
        articles: [:category_id, :subcategory_id, :team_id, :article_id, :show],
        breakdowns: [:category_id, :subcategory_id, :team_id, :show],
        photo_of_the_day: [:image, :alt, :title, :description, :author, :show],
        settings: [:show_popular_articles, :show_commented_articles]
      )
    end
  end
end
