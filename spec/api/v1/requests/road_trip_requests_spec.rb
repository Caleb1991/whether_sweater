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
  expect(json[:data][:attributes][:weather_at_eta]).to_not have_key(:uvi)
  expect(json[:data][:attributes][:weather_at_eta]).to_not have_key(:feels_like)
  end

  it 'sends error if bad api key' do
    WebMock.allow_net_connect!

    road_trip_payload = {
  origin: "Denver,CO",
  destination: "Phoenix,AZ",
  api_key: 1
  }

    post '/api/v1/road_trip', params: road_trip_payload, as: :json

    expect(response).to_not be_successful

    errors = JSON.parse(response.body, symbolize_names: true)

    expect(errors[:data][:attributes][:errors]).to eq('Your api key is invalid')
    expect(errors[:data][:attributes]).to_not have_key(:weather_at_eta)
  end

  it 'sends an error if location is unreachable by car' do
    WebMock.allow_net_connect!

    road_trip_payload = {
  origin: "Denver,CO",
  destination: "London,England",
  api_key: User.last.api_key
  }

    post '/api/v1/road_trip', params: road_trip_payload, as: :json

    expect(response).to_not be_successful

    errors = JSON.parse(response.body, symbolize_names: true)

    expect(errors[:data][:attributes][:travel_time]).to eq('Impossible destination')
    expect(errors[:data][:attributes][:weather_at_eta]).to_not have_key(:temperature)
    expect(errors[:data][:attributes][:weather_at_eta]).to_not have_key(:conditions)
  end
end
