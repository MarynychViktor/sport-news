class SearchesController < ApplicationController
  def show
    @articles = Articles::SuggestByHeadlineService.call(params[:query], page: params[:page] || 1, limit: params[:limit] || 5)
  end
end
