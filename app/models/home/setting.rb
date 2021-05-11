module Home
  class Setting < ApplicationRecord
    validates_inclusion_of :show_popular_articles, :show_commented_articles, in: [true, false]

    def self.instance
      first_or_initialize
    end
  end
end
