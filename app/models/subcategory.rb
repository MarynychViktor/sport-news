class Subcategory < ApplicationRecord
  include Hideable
  include Prioritizable

  default_scope { order(priority: :desc) }

  belongs_to :category
  has_many :teams, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: { scope: :category_id }
end
