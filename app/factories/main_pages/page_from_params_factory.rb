module MainPages
  class PageFromParamsFactory
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
      MainPages::PageBuilder.build do |builder|
        builder.articles(*with_defaults(@article_params))
        builder.breakdowns(*with_defaults(@breakdown_params))
        builder.photo_of_the_day(with_attributes(Home::PhotoOfTheDay.instance, @photo_params))
        builder.settings(with_attributes(Home::Setting.instance, @setting_params))
      end
    end

    private

    def with_attributes(object, attributes)
      object.assign_attributes(attributes)
      object
    end

    def with_defaults(params_list)
      params_list.map { |params| { show: false, **params.to_hash } }
    end
  end
end
