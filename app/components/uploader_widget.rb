class UploaderWidget < ViewComponent::Base

  def initialize(form, field_name)
    @form = form
    @field_name = field_name
    @id = "photo_#{form.object_id}"
    super
  end
end
