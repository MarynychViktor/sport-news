module Result
  class Success < Result
    def failed?
      false
    end

    def success?
      true
    end
  end
end
