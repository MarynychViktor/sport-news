module CMS
  class InfoArchitectureController < ApplicationController
    layout 'admin'

    def show
      @categories = Category.order(priority: :desc)
    end
  end
end
