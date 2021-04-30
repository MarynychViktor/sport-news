module Users
  class DeviseController < ApplicationController
    layout 'authentication'
    before_action :configure_permitted_parameters

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name photo])
    end

    def after_sign_in_path_for(resource)
      puts "------------resource"
      if resource.has_role?(:admin)
        cms_root_path
      else
        root_path
      end
    end
  end
end