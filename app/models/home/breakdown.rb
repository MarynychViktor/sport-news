module Home
  class Breakdown < ApplicationRecord
    belongs_to :category
    belongs_to :subcategory, optional: true
    belongs_to :team, optional: true

    validates :category_id, presence: true

    default_scope { includes(:category, :subcategory, :team).order(:created_at) }

    scope :visible, -> { where(show: true) }

    def articles
      (team || subcategory || category).articles.take(4)
    end

    def self.resolve
      breakdowns = all.to_a
      breakdowns << new if breakdowns.empty?
      breakdowns
    end

    def self.build_from(params)
      params.dup.map do |attributes|
        attributes[:show] ||= false
        breakdown = new(attributes)
        breakdown
      end
    end

    def self.upsert_home_breakdowns(breakdowns)
      transaction do
        breakdowns.each(&:save!)
        unscoped.where.not(id: breakdowns.map(&:id)).destroy_all
      end
    end
  end
end
