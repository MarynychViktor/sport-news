module CMS
  class InfoArchitectureController < ApplicationController
    def show
      @categories = Category.all
    end
  end
end
