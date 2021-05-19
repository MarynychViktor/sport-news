module Home
  class MainPage
    include ActiveModel::Validations

    attr_accessor :articles, :breakdowns, :photo_of_the_day, :settings

    validates_with ActiveRecord::Validations::AssociatedValidator, attributes: %i[articles breakdowns photo_of_the_day settings]

    def initialize
      @articles = []
      @breakdowns = []
    end

    def save
      return false unless valid?

      ActiveRecord::Base.transaction do
        @articles.each(&:save!)
        Home::Article.where.not(id: articles.map(&:id)).destroy_all

        @breakdowns.each(&:save!)
        Home::Breakdown.where.not(id: breakdowns.map(&:id)).destroy_all

        @photo_of_the_day.save!
        @settings.save!
      end

      true
    end
  end
end