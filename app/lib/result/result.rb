module Result
  class Result < OpenStruct
    def success?
      raise 'Not implemented'
    end

    def failed?
      raise 'Not implemented'
    end
  end
end