module Home
  class Breakdown < ApplicationRecord
    belongs_to :category
    belongs_to :subcategory, optional: true
    belongs_to :team, optional: true

    validates :category_id, presence: true

    scope :with_categories_and_team, -> { includes(:category, :subcategory, :team) }
    scope :visible, -> { where(show: true) }

    # TODO: refactor/remove
    def articles
      (team || subcategory || category).articles.take(4)
    end
  end
end
