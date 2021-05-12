module Customer
  class SearchesController < ApplicationController
    def show
      @articles = Article.search_by_title_and_content(params[:query],
                                                      page: params[:page] || 1,
                                                      limit: params[:limit] || 5)

    end
  end
end