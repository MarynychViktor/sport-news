module Hideable
  extend ActiveSupport::Concern

  included do
    scope :visible, -> { where(hidden: false) }
    scope :hidden, -> { where(hidden: true) }
  end

  def hide!
    self.hidden = true
    save!
  end

  def appear!
    self.hidden = false
    save!
  end
end
