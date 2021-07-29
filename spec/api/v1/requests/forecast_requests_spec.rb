require 'rails_helper'

RSpec.describe 'Forecast API' do
  it 'sends the forecast for a given city and state' do
    coordinates = GeocodingFacade.create_coordinates_object('Denver,CO')

    response = OpenWeatherApiService.get_weather_for_given_coordinates(coordinates.latitude, coordinates.longitude)
    binding.pry
  end
end
