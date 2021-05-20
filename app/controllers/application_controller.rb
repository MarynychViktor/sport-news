class ApplicationController < ActionController::Base
  include Pundit
  include Paginable
  include AuthorizationErrorHandler

  layout 'application'
end
