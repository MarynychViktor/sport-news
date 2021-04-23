class Category < ApplicationRecord
  include Hideable

  has_many :subcategories, dependent: :destroy
end
