module TeamRequest
  class Update < ApplicationRequestBase
    def rules(validator)
      validator.params do
        required(:id).value(:integer)
        required(:category_id).value(:integer)
        required(:hidden).value(:bool)
      end
    end
  end
end