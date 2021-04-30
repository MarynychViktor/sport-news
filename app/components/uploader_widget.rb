class UploaderWidget < ViewComponent::Base

  def initialize(form, field_name)
    @form = form
    @field_name = field_name
    @id = "#{field_name}_#{form.object_id}"
    super
  end

  def build_field
    @form.input(@field_name.to_sym, as: :hidden, label: false, input_html: { class: 'd-none' }, error_html: { class: 'app-input-error' })
  end
end
