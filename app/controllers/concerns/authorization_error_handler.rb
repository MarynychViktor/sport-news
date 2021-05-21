module AuthorizationErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError, with: :handle_authorization_exception

    def handle_authorization_exception
      if user_signed_in?
        head :forbidden
      else
        authenticate_user!
      end
    end
  end
end
