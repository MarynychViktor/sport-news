class SidebarComponent < ViewComponent::Base
  def initialize
    @categories = Category.includes(subcategories: :teams)
    super
  end
end
