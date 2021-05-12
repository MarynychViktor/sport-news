module Customer
  class SearchesController < ApplicationController
    def show
      @articles = Articles::Searcher.new.search_by_title(params[:query],
                                                         page: params[:page] || 1,
                                                         limit: params[:limit] || 5)
    end
  end
end
