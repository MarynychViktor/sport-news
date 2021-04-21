class ApplicationController < ActionController::Base
  before_action :check_user

  def check_user
    @current_user = nil?
  end
end
