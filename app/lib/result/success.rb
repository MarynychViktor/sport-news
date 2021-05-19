module Result
  class Success < Result
    def initialize(result)
      super(result, true)
    end
  end
end