module Result
  # TODO: check OpenStruct
  class Result
    attr_reader :result

    def initialize(result, success)
      @result = result
      @success = success
    end

    def success?
      @success
    end

    def failed?
      !@success
    end
  end
end