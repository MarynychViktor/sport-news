module Customer
  class ApplicationController < ActionController::Base
    include Pagination

    layout 'application'
  end
end
