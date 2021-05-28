module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      auth = request.env['omniauth.auth']
      user = Users::ResolveOauthUserService.call(auth.provider, auth.uid, auth.info).user
      sign_in_and_redirect user, event: :authentication
    end

    def failure
      redirect_to new_user_session_path
    end
  end
end
