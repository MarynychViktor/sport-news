module CategoryRequest
  class Create < ApplicationRequestBase
    def rules(validator)
      validator.params do
        required(:name).value(:string, :filled?, size?: 2..50)
      end

      validator.rule(:name) do
        key.failure('name already taken') if Category.find_by(name: values[:name])
      end
    end
  end
end