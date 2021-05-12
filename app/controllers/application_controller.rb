class ApplicationController < ActionController::Base
  # TODO: remove unused statements
  before_action :load_categories

  private

  # TODO: remove unused statements
  def load_categories
    @_categories = Category.all
  end
end
