module Home
  class PersistMainPage
    include Callable
    include Result::Helpers

    attr_accessor :main_page

    def initialize(article_params, breakdown_params, photo_params, setting_params)
      @article_params = article_params.dup
      @breakdown_params = breakdown_params.dup
      @photo_params = photo_params.dup
      @setting_params = setting_params.dup
    end

    def call
      build_main_page

      if @main_page.save
        success(@main_page)
      else
        failed(@main_page)
      end
    end

    private

    def build_main_page
      @main_page = MainPageBuilder.build do |builder|
        @article_params.map do |attributes|
          builder.add_article(Home::Article.new({ show: false, **attributes }))
        end

        @breakdown_params.map do |attributes|
          builder.add_breakdown(Home::Breakdown.new({ show: false, **attributes }))
        end

        builder.set_photo_of_the_day(build_photo)
        builder.set_settings(build_settings)
      end
    end

    def build_photo
      photo = Home::PhotoOfTheDay.first_or_initialize
      photo.assign_attributes(@photo_params)
      photo
    end

    def build_settings
      settings = Home::Setting.first_or_initialize
      settings.assign_attributes(@setting_params)
      settings
    end
  end
end
