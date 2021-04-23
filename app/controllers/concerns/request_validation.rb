module RequestValidation
  extend ActiveSupport::Concern

  included do
    before_action :validate_request_schema

    def self.validate_request(schema, method:)
      # NOTE: class object instance variable!
      @request_schemas ||= {}
      methods = method.is_a?(Array) ? method : [method]
      methods.each do |m|
        # TODO: add parameters to build response type, like json, html
        @request_schemas[m.to_sym] = { schema: schema }
      end
    end
  end

  def req
    @request || params
  end

  def validate_request_schema
    @request = params
    current_action = action_name.to_sym
    return unless request_schemas[current_action]

    metadata = request_schemas[current_action]
    @request = build_request(metadata[:schema])
    # TODO: add support for other formats
    render(json: [errors: @request.errors.to_h], status: :bad_request) if @request.invalid?
  end

  private

  def request_schemas
    self.class.class_eval { @request_schemas ||= {} }
  end
end
