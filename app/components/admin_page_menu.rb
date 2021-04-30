class AdminPageMenu < ViewComponent::Base
  def initialize(category = nil)
    @category = category
    @categories = Category.all
    super
  end
end