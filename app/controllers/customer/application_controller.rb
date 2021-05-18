module Customer
  class ApplicationController < ActionController::Base
    include Pundit
    include Pagination

    layout 'application'
  end
end
