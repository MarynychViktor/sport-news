class SidebarComponent < ViewComponent::Base
  def initialize
    @categories = Category.all
    super
  end
end
