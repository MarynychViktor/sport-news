class GooglePlacesClient
  PLACES_AUTOCOMPLETE_URL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'.freeze
  PLACE_DETAILS_URL = 'https://maps.googleapis.com/maps/api/place/details/json'.freeze

  def find_places(input, type = '(cities)')
    response = request(build_autocomplete_url(input, type))
    return [] unless response['status'] == 'OK'

    response['predictions'].map do |prediction|
      { description: prediction['description'], place_id: prediction['place_id'] }
    end
  end

  def find_place_by_id(id)
    url = build_details_url(id)
    response = request(url)
    unless response['status'] == 'OK'
      raise ArgumentError, "Google Place Api request failed. #{response['error_message']}"
    end

    { description: response['result']['formatted_address'], place_id: response['result']['place_id'] }
  end

  private

  def request(url)
    response = Net::HTTP.get_response(URI(url))
    unless response.code.to_i == 200
      raise ArgumentError, "Google Place Api request failed. Status code: #{response.code.to_i}"
    end

    JSON.parse(response.body)
  end

  def build_autocomplete_url(query, type)
    "#{PLACES_AUTOCOMPLETE_URL}?key=#{api_key}&input=#{query}&type=#{type}"
  end

  def build_details_url(id)
    "#{PLACE_DETAILS_URL}?key=#{api_key}&placeid=#{id}"
  end

  def api_key
    ENV['GOOGLE_API_KEY']
  end
end
