class Category < ApplicationRecord
  include Hideable
  include Ranked

  has_many :subcategories, dependent: :destroy
  has_many :articles
  has_many :teams, through: :subcategories

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }, uniqueness: true

  before_destroy :check_if_can_be_destroyed

  def find_teams(**query)
    known_values = query.slice(:subcategory_id)
    filtered_query = filter_empty_values(known_values)
    teams.where(filtered_query)
  end

  def find_articles(**query)
    known_values = query.slice(:subcategory_id, :team_id)
    filtered_query = filter_empty_values(known_values)
    articles.where(filtered_query)
  end

  def check_if_can_be_destroyed
    return true unless static?

    errors.add(:base, :immutable, "Record is static and can't be destroyed")
    false
  end

  private

  def filter_empty_values(**input)
    query = {}
    input.each { |key, value| query[key] = value if value && !value.empty? }
    query
  end
end
