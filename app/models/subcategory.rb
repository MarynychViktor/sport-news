class Subcategory < ApplicationRecord
  include Hideable

  belongs_to :category
  has_many :teams, dependent: :destroy
end
