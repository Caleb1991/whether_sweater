class OpenWeatherFacade
  def self.create_weather_object(city_state)
    coordinates = GeocodingFacade.create_coordinates_object(city_state)
    json = OpenWeatherApiService.get_weather_for_given_coordinates(coordinates.latitude, coordinates.longitude)

    WeatherPackage.new(json[:current], json[:daily][0..4], json[:hourly][0..7], json[:timezone_offset])
  end
end
