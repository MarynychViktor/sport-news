module CMS
  class ApplicationController < ActionController::Base
    include Pagination

    layout 'cms'

    before_action :require_admin_role

    private

    def require_admin_role
      if user_signed_in?
        head :forbidden unless current_user.has_role?(:admin)
      else
        authenticate_user!
      end
    end
  end
end