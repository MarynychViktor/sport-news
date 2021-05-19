module Locations
  class ResolveByPlaceId
    include Service

    def initialize(id)
      @place_id = id
      @places_client = GooglePlacesClient.new
    end

    def call
      location = Location.find_by(place_id: @place_id)
      return success(location) if location

      details = @places_client.find_place_by_id(@place_id)
      success(Location.create({title: details[:description], place_id: @place_id}))
    rescue ArgumentError => e
      failed(e)
    end
  end
end