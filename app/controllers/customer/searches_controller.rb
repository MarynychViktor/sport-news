module Customer
  class SearchesController < ApplicationController
    def show
      searcher = Articles::Searcher.new(params[:query], page: params[:page] || 1, limit: params[:limit] || 5)
      @articles = searcher.call
    end
  end
end
