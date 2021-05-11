module Home
  class Setting < ApplicationRecord
    validates :show_popular_articles, :show_commented_articles, presence: true
  end
end
