class Category < ApplicationRecord
  include Hideable

  has_many :children, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Category', optional: true
  has_many :teams, dependent: :destroy

  scope :root_categories, -> { where(parent: nil) }
  scope :subcategories, -> { where.not(parent: nil) }
end
