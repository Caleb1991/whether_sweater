require 'rails_helper'

RSpec.describe 'Background API Endpoint' do
  describe 'index' do
    it 'returns an image url when given location params' do
      body = File.read('spec/fixtures/image_search.json')

      stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['unsplash_api_key']}&per_page=1&query=Denver,CO").
        to_return(status: 200, body: body, headers: {})

      get '/api/v1/backgrounds?location=Denver,CO'

      expect(response).to be_successful

      image_url = JSON.parse(response.body, symbolize_names:true)

      expect(image_url[:data][:attributes][:location]).to be_a(String)
      expect(image_url[:data][:attributes][:image_url]).to be_a(String)
      expect(image_url[:data][:attributes][:crediting][:disclaimer]).to be_a(String)
    end

    it 'returns an error when location is invalid' do
      get '/api/v1/backgrounds?location='

      expect(response).to_not be_successful

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:data][:attributes][:errors]).to eq('Invalid location.')
      expect(error[:data][:attributes]).to_not have_key(:location)
      expect(error[:data][:attributes]).to_not have_key(:image_url)
      expect(error[:data][:attributes]).to_not have_key(:crediting)
    end
  end
end
