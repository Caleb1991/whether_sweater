require 'rails_helper'

RSpec.describe 'Road Trip API' do
  before :each do
    user_payload = {
      email: 'Roald91',
      password: 'IceCold',
      password_confirmation: 'IceCold'
      }

    post '/api/v1/users', params: user_payload, as: :json
end

  it 'sends data for a given road trip' do
    route_body = File.read('spec/fixtures/road_trip_search.json')

    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{ENV['geocoding_api_key']}&to=Phoenix,AZ").
         to_return(status: 200, body: route_body, headers: {})

    coordinates_body = File.read('spec/fixtures/coordinates_search.json')

    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['geocoding_api_key']}&location=Phoenix,AZ").
        to_return(status: 200, body: coordinates_body, headers: {})

    weather_body = File.read('spec/fixtures/weather_for_travel_destination.json')

    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['openweather_api_key']}&lat=39.738453&lon=-104.984853&units=imperial").
           to_return(status: 200, body: weather_body, headers: {})

    road_trip_payload = {
  origin: "Denver,CO",
  destination: "Phoenix,AZ",
  api_key: User.last.api_key
  }

  post '/api/v1/road_trip', params: road_trip_payload, as: :json

  expect(response).to be_successful

  json = JSON.parse(response.body, symbolize_names: true)

  expect(json[:data][:attributes][:start_city]).to eq('Denver,CO')
  expect(json[:data][:attributes][:end_city]).to eq('Phoenix,AZ')
  expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
  expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
  end
end
