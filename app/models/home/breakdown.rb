# == Schema Information
#
# Table name: home_breakdowns
#
#  id             :bigint           not null, primary key
#  show           :boolean          default(TRUE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :bigint           not null
#  subcategory_id :bigint
#  team_id        :bigint
#
# Indexes
#
#  index_home_breakdowns_on_category_id     (category_id)
#  index_home_breakdowns_on_subcategory_id  (subcategory_id)
#  index_home_breakdowns_on_team_id         (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (subcategory_id => subcategories.id)
#  fk_rails_...  (team_id => teams.id)
#
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
