class ApplicationController < ActionController::Base
  before_action :check_user
  before_action :load_categories

  def check_user
    @current_user = nil
  end

  private

  def load_categories
    @_categories = Category.all
  end
end
