module Result
  class Failed < Result
    def initialize(result)
      super(result, false)
    end
  end
end