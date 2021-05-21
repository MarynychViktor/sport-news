module Service
  extend ActiveSupport::Concern

  included do
    include Callable
    include Result::Helpers
  end
end
