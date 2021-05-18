module Customer
  class ApplicationController < ActionController::Base
    include Pundit
    include Pagination
    include AuthorizationErrorHandler

    layout 'application'
  end
end
