class Team < ApplicationRecord
  include Hideable
  include Prioritizable

  default_scope { order(priority: :desc) }

  belongs_to :subcategory
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: { scope: :subcategory_id }
end
