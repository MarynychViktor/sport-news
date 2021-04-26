module Ranked
  extend ActiveSupport::Concern

  included do
    include RankedModel
    ranks :row_order
    default_scope { order(row_order: :asc) }
    after_create :set_first_order
  end

  def update_position!(new_position)
    self.row_order_position = new_position
    save!
  end

  def set_first_order
    update_position! 0
  end
end
