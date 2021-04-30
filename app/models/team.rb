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
