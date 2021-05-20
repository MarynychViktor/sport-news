module CMS
  class PlacesController < ApplicationController
    def index
      response = Places::SearchCitiesService.call(params[:query])

      if response.success?
        render json: response.result
      else
        render json: response.result, status: 400
      end
    end
  end
end