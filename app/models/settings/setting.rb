module Settings
  class Setting
    include ActiveModel::Conversion
    include ActiveModel::Validations
    include ActiveModel::AttributeAssignment
    extend ActiveModel::Naming

    def initialize(attributes = nil)
      assign_attributes(attributes) if attributes
    end

    def persisted?
      false
    end
  end
end
