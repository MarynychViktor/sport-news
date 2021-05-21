class CategorizedItemComponent < ViewComponent::Base
  renders_many :menu_links, Dropdown::LinkComponent

  def initialize(item, click_link: nil, class_name: '', data_attributes: {})
    @item = item
    @click_link = click_link
    @data_attributes = data_attributes
    @class_name = class_name
    super
  end
end
