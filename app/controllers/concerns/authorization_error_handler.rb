module AuthorizationErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError, with: :handle_authorization_exception
    rescue_from AppActionNotAllowedException, with: :handle_not_allowed_exception

    def handle_authorization_exception
      if user_signed_in?
        head :forbidden
      else
        authenticate_user!
      end
    end

    def handle_not_allowed_exception
      head :bad_request
    end
  end
end
