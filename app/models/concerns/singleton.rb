module Singleton
  extend ActiveSupport::Concern

  included do
    private_class_method :new

    before_save :ensure_singleton

    class << self
      def instance
        first_or_initialize
      end
    end

    def ensure_singleton
      return if persisted? || self.class.count.zero?

      raise "Only single instance of #{self.class.name} allowed"
    end
  end
end
