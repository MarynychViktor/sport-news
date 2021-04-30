module Users
  class DeviseController < ApplicationController
    layout 'authentication'
    before_action :configure_permitted_parameters

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name photo])
    end
  end
end