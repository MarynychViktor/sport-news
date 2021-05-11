class Home::Breakdown < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory, optional: true
  belongs_to :team, optional: true
  validates :category_id, presence: true

  default_scope { includes(:category, :subcategory, :team).order(:created_at) }
end
