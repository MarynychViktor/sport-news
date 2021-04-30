class AdminPageMenu < ViewComponent::Base
  def initialize
    @categories = Category.all
    super
  end
end