class Category < ApplicationRecord
  include Hideable
  include Ranked

  has_many :subcategories, dependent: :destroy
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: true

  before_destroy :check_if_can_be_destroyed

  def check_if_can_be_destroyed
    return true unless static?

    errors.add(:base, :immutable, "Record is static and can't be destroyed")
    false
  end
end
