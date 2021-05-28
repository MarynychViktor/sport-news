module Result
  module Helpers
    def success(*args)
      Success.new(*args)
    end

    def failed(*args)
      Failed.new(*args)
    end
  end
end