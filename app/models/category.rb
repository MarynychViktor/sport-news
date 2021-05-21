# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  hidden     :boolean          default(FALSE)
#  name       :string           not null
#  row_order  :integer
#  static     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#
class Category < ApplicationRecord
  include Hideable
  include Ranked

  has_many :subcategories, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :teams, through: :subcategories

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: true
  # todo: review
  scope :with_visible_subcategories_and_teams, lambda {
    visible.includes(subcategories: :teams)
           .where(subcategories: { hidden: [false, nil], teams: { hidden: [false, nil] } })
  }

  before_destroy :check_if_can_be_destroyed

  def check_if_can_be_destroyed
    return true unless static?

    errors.add(:base, :immutable, "Record is static and can't be destroyed")
    false
  end
end
