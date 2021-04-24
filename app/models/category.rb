class Category < ApplicationRecord
  include Hideable
  include Prioritizable

  has_many :subcategories, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: true
  validates :priority, uniqueness: true
end
