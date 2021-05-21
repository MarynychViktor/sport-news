class ApplicationController < ActionController::Base
  include Pundit
  include Paginable
  include AuthorizationErrorHandler
  around_action :switch_locale

  layout 'application'

  private

  def default_url_options
    { locale: params[:locale] || I18n.locale }
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.locale
    I18n.with_locale(locale, &action)
  end
end
