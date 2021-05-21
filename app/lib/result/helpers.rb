module Result
  module Helpers
    def success(result = nil)
      Success.new(result)
    end

    def failed(result = nil)
      Failed.new(result)
    end
  end
end