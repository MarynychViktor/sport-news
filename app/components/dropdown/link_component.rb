module Dropdown
  class LinkComponent < ViewComponent::Base
    renders_many :links, LinkComponent

    # def initialize
    #   super
    # end
  end
end
