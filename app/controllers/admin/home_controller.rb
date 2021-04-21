# frozen_string_literal: true

# Admin controller
module Admin
  # Home controller
  class HomeController < ApplicationController
    layout 'admin'

    def index
      @current_user = 'John Smith'
    end
  end
end
