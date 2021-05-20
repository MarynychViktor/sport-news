# frozen_string_literal: true
module Places
  class SearchCitiesService
    include Service

    def initialize(query)
      @query = query
      @places_client = GooglePlacesClient.new
    end

    def call
      if @query && !@query.empty?
        places = @places_client.find_places(@query)
        success(places)
      else
        failed({ error: ':query is required' })
      end
    end
  end
end
