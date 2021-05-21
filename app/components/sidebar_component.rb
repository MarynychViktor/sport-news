class SidebarComponent < ViewComponent::Base
  def initialize
    @categories = Category.with_visible_subcategories_and_teams
    super
  end
end
