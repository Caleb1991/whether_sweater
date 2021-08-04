require 'rails_helper'

RSpec.describe 'Background API Endpoint' do
  describe 'index' do
    it 'returns an image url when given location params' do
      body = File.read('spec/fixtures/image_search.json')

      stub_request(:get, "https://api.unsplash.com/search/photos?client_id=aNgJTCW3VkD5RH9Hu1aYsx-OqSd7a2P6v8MVVfI-bAw&per_page=1&query=Denver,CO").
        to_return(status: 200, body: body, headers: {})

      get '/api/v1/backgrounds?location=Denver,CO'

      expect(response).to be_successful

      image_url = JSON.parse(response.body, symbolize_names:true)

      expect(image_url[:data][:attributes][:location]).to be_a(String)
      expect(image_url[:data][:attributes][:image_url]).to be_a(String)
      expect(image_url[:data][:attributes][:crediting][:disclaimer]).to be_a(String)
    end
  end
end
