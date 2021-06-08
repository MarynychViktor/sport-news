module CMS
  class PlacesController < ApplicationController
    def index
      response = Places::SearchCitiesService.call(params[:query])

      if response.success?
        render json: response.places
      else
        render json: response.error, status: 400
      end
    end
  end
end