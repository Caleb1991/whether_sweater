class RoadTripFacade

  def self.plan_road_trip(attributes)
    travel_time = Route.new(GeocodingApiService.get_route_information(attributes[:origin], attributes[:destination]))

    coordinates = Coordinates.new(GeocodingApiService.get_lat_and_long(attributes[:destination])[:results])

    weather_at_destination = OpenWeatherApiService.get_weather_for_given_coordinates(coordinates.latitude, coordinates.longitude)

    road_trip_object = RoadTrip.new(attributes[:origin], attributes[:destination], weather_at_destination, travel_time)
  end
end
