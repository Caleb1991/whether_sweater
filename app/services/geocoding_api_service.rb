class GeocodingApiService
  def self.get_lat_and_long(city_state)
    response = conn.get("/geocoding/v1/address") do |req|
      req.params['key'] = ENV['geocoding_api_key']
      req.params['location'] = city_state
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_route_information(origin, destination)
    response = conn.get('/directions/v2/route') do |req|
      req.params['key'] = ENV['geocoding_api_key']
      req.params['from'] = origin
      req.params['to'] = destination
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com')
  end
end
