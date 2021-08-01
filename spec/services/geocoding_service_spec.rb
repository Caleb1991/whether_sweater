require 'rails_helper'

RSpec.describe GeocodingApiService do
  it 'returns latitude and longitude for a given location' do
    response_body = File.read('spec/fixtures/coordinates_search.json')

    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['geocoding_api_key']}&location=Denver,CO").
         to_return(status: 200, body: response_body, headers: {})


    json = GeocodingApiService.get_lat_and_long('Denver,CO')

    expect(json[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
    expect(json[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
  end
end
