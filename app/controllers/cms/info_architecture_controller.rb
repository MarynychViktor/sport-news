module CMS
  class InfoArchitectureController < ApplicationController
    layout :admin

    def show
      @categories = Category.all
    end
  end
end
