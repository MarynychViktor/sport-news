class ApplicationController < ActionController::Base
  before_action :load_categories

  private

  def load_categories
    @_categories = Category.all
  end
end
