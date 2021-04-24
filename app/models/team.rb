class Team < ApplicationRecord
  include Hideable
  include Prioritizable

  belongs_to :subcategory

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: { scope: :subcategory_id }
end
