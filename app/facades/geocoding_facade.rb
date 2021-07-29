class GeocodingFacade
  def self.create_coordinates_object(city_and_state)
    json = GeocodingApiService.get_lat_and_long(city_and_state)

    Coordinates.new(json[:results])
  end
end
