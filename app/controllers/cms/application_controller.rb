module CMS
  class ApplicationController < ActionController::Base
    include AuthorizationErrorHandler
    include Paginable
    include Pundit
    before_action :require_admin_role

    layout 'cms'

    private

    def require_admin_role
      if user_signed_in?
        head :forbidden unless current_user.admin?
      else
        authenticate_user!
      end
    end
  end
end