require 'rails_helper'


RSpec.describe OpenWeatherFacade do
  describe '#create_weather_object' do
    it 'creates a weather object' do
      coordinates_body = File.read('spec/fixtures/coordinates_search.json')

      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['geocoding_api_key']}&location=Denver,CO").
           to_return(status: 200, body: coordinates_body, headers: {})

      weather_body = File.read('spec/fixtures/weather_search.json')

      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['openweather_api_key']}&exclude=%7Bpart%7D&lat=39.738453&lon=-104.984853&units=imperial").
         to_return(status: 200, body: weather_body, headers: {})

      weather = OpenWeatherFacade.create_weather_object('Denver,CO')

      expect(weather.current_forecast[:date]).to be_a(Date)
      expect(weather.five_day_forecast[0][:date]).to be_a(Date)
      expect(weather.eight_hour_forecast[0][:date]).to be_a(Date)

      expect(weather.current_forecast[:temperature]).to be_a(Float)
      expect(weather.five_day_forecast[0][:high]).to be_a(Float)
      expect(weather.eight_hour_forecast[0][:temperature]).to be_a(Float)

      expect(weather.current_forecast[:conditions]).to be_a(String)
      expect(weather.five_day_forecast[0][:conditions]).to be_a(String)
      expect(weather.eight_hour_forecast[0][:conditions]).to be_a(String)

      expect(weather.current_forecast[:icon]).to be_a(String)
      expect(weather.five_day_forecast[0][:icon]).to be_a(String)
      expect(weather.eight_hour_forecast[0][:icon]).to be_a(String)
    end
  end
end
