class GeocodingApiService
  def self.get_lat_and_long(city_state)
    response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address") do |req|
      req.params['key'] = ENV['geocoding_api_key']
      req.params['location'] = city_state
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
