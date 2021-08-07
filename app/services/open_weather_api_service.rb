class OpenWeatherApiService
  def self.get_weather_for_given_coordinates(latitude, longitude, units = 'imperial')
    response = Faraday.get('https://api.openweathermap.org/data/2.5/onecall') do |req|
      req.params['lat'] = latitude
      req.params['lon'] = longitude
      req.params['units'] = units
      req.params['appid'] = ENV['openweather_api_key']
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
