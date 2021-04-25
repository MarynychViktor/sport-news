class Category < ApplicationRecord
  include Hideable
  include Prioritizable

  default_scope { order(priority: :desc) }

  has_many :subcategories, -> { order(priority: :desc) }, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: true
  validates :priority, uniqueness: true
end
