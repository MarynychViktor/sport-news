module Dropdown
  class MenuComponent < ViewComponent::Base
    renders_one :button, ButtonComponent
    renders_many :links, LinkComponent

    def initialize(id:, class_name: '', show: false)
      @id = id
      @class_name = class_name
      @show = show
      super
    end
  end
end
