module Result
  class Failed < Result
    def failed?
      true
    end

    def success?
      false
    end
  end
end
