module Hideable
  extend ActiveSupport::Concern

  included do
    scope :visible, -> { where(hidden: false) }
    scope :hidden, -> { where(hidden: true) }
  end

  def mark_hidden!
    self.hidden = true
    save!
  end

  def mark_visible!
    self.hidden = false
    save!
  end
end
