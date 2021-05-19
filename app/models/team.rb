# == Schema Information
#
# Table name: teams
#
#  id             :bigint           not null, primary key
#  hidden         :boolean          default(FALSE)
#  name           :string           not null
#  row_order      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  subcategory_id :bigint           not null
#
# Indexes
#
#  index_teams_on_name_and_subcategory_id  (name,subcategory_id) UNIQUE
#  index_teams_on_subcategory_id           (subcategory_id)
#
# Foreign Keys
#
#  fk_rails_...  (subcategory_id => subcategories.id)
#
class Team < ApplicationRecord
  include Hideable
  include Ranked

  belongs_to :subcategory
  has_many :articles

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: { scope: :subcategory_id }

  def update_position!(new_position)
    ranks = self.class.where(subcategory_id: subcategory_id).rank(:row_order).map(&:row_order_rank)
    super(ranks[new_position])
  end
end
