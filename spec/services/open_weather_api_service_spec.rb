require 'rails_helper'

RSpec.describe OpenWeatherApiService do
  describe 'get_weather_for_given_coordinates' do
    it 'returns weather response for given coordinates' do
      coordinates_body = File.read('spec/fixtures/coordinates_search.json')

      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['geocoding_api_key']}&location=Denver,CO").
           to_return(status: 200, body: coordinates_body, headers: {})

      coordinates = GeocodingFacade.create_coordinates_object('Denver,CO')
      weather_body = File.read('spec/fixtures/weather_search.json')

      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['openweather_api_key']}&lat=39.738453&lon=-104.984853&units=imperial").
         to_return(status: 200, body: weather_body, headers: {})

      response = OpenWeatherApiService.get_weather_for_given_coordinates(coordinates.latitude, coordinates.longitude)

      expect(response[:current][:dt]).to be_an(Integer)
      expect(response[:current][:sunrise]).to be_an(Integer)
      expect(response[:current][:sunset]).to be_an(Integer)
      expect(response[:current][:temp]).to be_a(Float)
      expect(response[:current][:feels_like]).to be_a(Float)
      expect(response[:current][:humidity]).to be_an(Integer)
      expect(response[:current][:uvi]).to be_a(Float)
      expect(response[:current][:visibility]).to be_an(Integer)
      expect(response[:current][:weather][0][:description]).to be_a(String)
      expect(response[:current][:weather][0][:icon]).to be_a(String)

      expect(response[:daily][0][:dt]).to be_an(Integer)
      expect(response[:daily][0][:sunrise]).to be_an(Integer)
      expect(response[:daily][0][:sunset]).to be_an(Integer)
      expect(response[:daily][0][:temp][:max]).to be_a(Float)
      expect(response[:daily][0][:temp][:min]).to be_a(Float)
      expect(response[:daily][0][:weather][0][:description]).to be_a(String)
      expect(response[:daily][0][:weather][0][:icon]).to be_a(String)

      expect(response[:hourly][0][:dt]).to be_an(Integer)
      expect(response[:hourly][0][:temp]).to be_a(Float)
      expect(response[:hourly][0][:weather][0][:description]).to be_a(String)
      expect(response[:hourly][0][:weather][0][:icon]).to be_a(String)
    end
  end

  describe 'get_weather_for_destination_coordinates_upon_arrival' do
    it 'returns weather for given destination at given time' do
      weather_body = File.read('spec/fixtures/weather_for_travel_destination.json')

      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=78a1bb9c2da4def0f719610a46bf899c&lat=33.448204&lon=-112.072585&units=1628292136").
         to_return(status: 200, body: weather_body, headers: {})

      json = OpenWeatherApiService.get_weather_for_given_coordinates('33.448204', '-112.072585', '1628292136')

      expect(json[:current][:temp]).to be_a(Float)
      expect(json[:current][:weather][0][:description]).to be_a(String)
    end
  end
end
