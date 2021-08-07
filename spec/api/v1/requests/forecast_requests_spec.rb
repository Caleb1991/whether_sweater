require 'rails_helper'

RSpec.describe 'Forecast API' do
  describe '#get_weather_for_given_coordinates' do
    it 'sends the forecast for a given city and state' do
      coordinates_body = File.read('spec/fixtures/coordinates_search.json')

      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['geocoding_api_key']}&location=Denver,CO").
           to_return(status: 200, body: coordinates_body, headers: {})

      weather_body = File.read('spec/fixtures/weather_search.json')

      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['openweather_api_key']}&lat=39.738453&lon=-104.984853&units=imperial").
         to_return(status: 200, body: weather_body, headers: {})


      get '/api/v1/forecasts?location=Denver,CO'

      expect(response).to be_successful

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast[:data][:attributes][:five_day_forecast].count).to eq(5)
      forecast[:data][:attributes][:five_day_forecast].each do |forecast|
        expect(forecast[:date]).to be_a(String)
        expect(forecast[:sunrise]).to be_a(String)
        expect(forecast[:sunset]).to be_a(String)
        expect(forecast[:conditions]).to be_a(String)
        expect(forecast[:icon]).to be_a(String)
        expect(forecast[:high]).to be_a(Float)
        expect(forecast[:low]).to be_a(Float)
      end

      expect(forecast[:data][:attributes][:eight_hour_forecast].count).to eq(8)
      forecast[:data][:attributes][:eight_hour_forecast].each do |forecast|
        expect(forecast[:date]).to be_a(String)
        expect(forecast[:conditions]).to be_a(String)
        expect(forecast[:icon]).to be_a(String)
        expect(forecast[:temperature]).to be_a(Float)
      end
    end
  end
end
