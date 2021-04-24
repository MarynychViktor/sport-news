module Prioritizable
  extend ActiveSupport::Concern

  included do
    before_create :set_priority
  end

  private

  def set_priority
    most_prioritized_category = self.class.order(priority: :desc).first
    self.priority = most_prioritized_category ? most_prioritized_category.priority + 1 : 1
  end
end
