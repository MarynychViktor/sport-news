class ApplicationRequestBase
  def initialize(params)
    @params = params
  end

  def data
    @result.values
  end

  def [](key)
    data[key]
  end

  def valid?
    validation_result.success?
  end

  def invalid?
    !valid?
  end

  def errors
    @result.errors
  end

  private

  def validation_result
    return @result if @result

    request = self
    contract = Class.new(Dry::Validation::Contract) { request.rules(self) }
    @result = contract.new.call(@params)
  end
end
