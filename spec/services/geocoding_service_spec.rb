require 'rails_helper'

RSpec.describe GeocodingApiService do
  it 'returns latitude and longitude for a given location' do
    json = GeocodingApiService.get_lat_and_long('Denver,CO')

    expect(json[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
    expect(json[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
  end
end
