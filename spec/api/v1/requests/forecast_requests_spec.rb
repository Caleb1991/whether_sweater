require 'rails_helper'

RSpec.describe 'Forecast API' do
  it 'sends the forecast for a given city and state' do
    coordinates_body = File.read('spec/fixtures/coordinates_search.json')

    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['geocoding_api_key']}&location=Denver,CO").
         to_return(status: 200, body: coordinates_body, headers: {})

    coordinates = GeocodingFacade.create_coordinates_object('Denver,CO')
    weather_body = File.read('spec/fixtures/weather_search.json')

    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['openweather_api_key']}&exclude=%7Bpart%7D&lat=39.738453&lon=-104.984853&units=imperial").
        to_return(status: 200, body: weather_body, headers: {})

    response = OpenWeatherApiService.get_weather_for_given_coordinates(coordinates.latitude, coordinates.longitude)
  end
end
