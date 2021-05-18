class Subcategory < ApplicationRecord
  include Hideable
  include Ranked

  belongs_to :category
  has_many :teams, dependent: :destroy
  has_many :articles

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: { scope: :category_id }

  # todo move to service object?
  def update_position!(new_position)
    ranks = self.class.where(category_id: category_id).rank(:row_order).map(&:row_order_rank)
    super(ranks[new_position])
  end
end
