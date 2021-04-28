class AppValidationException < RuntimeError
  attr_reader :validation_result

  def initialize(result)
    super('Validation failed')
    @validation_result = result
  end
end
