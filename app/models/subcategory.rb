# == Schema Information
#
# Table name: subcategories
#
#  id          :bigint           not null, primary key
#  hidden      :boolean          default(FALSE)
#  name        :string           not null
#  row_order   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_subcategories_on_category_id           (category_id)
#  index_subcategories_on_name_and_category_id  (name,category_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Subcategory < ApplicationRecord
  include Hideable
  include Ranked

  belongs_to :category
  has_many :teams, dependent: :destroy
  has_many :articles, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: { scope: :category_id }

  # todo move to service object?
  def update_position!(new_position)
    ranks = self.class.where(category_id: category_id).rank(:row_order).map(&:row_order_rank)
    super(ranks[new_position])
  end
end
