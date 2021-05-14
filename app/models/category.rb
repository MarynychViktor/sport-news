class Category < ApplicationRecord
  include Hideable
  include Ranked

  has_many :subcategories, dependent: :destroy
  has_many :articles
  has_many :teams, through: :subcategories

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: true
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
