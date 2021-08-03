require 'rails_helper'

RSpec.describe UnsplashApiService do
  describe 'get_image_for_search_query' do
    it 'returns image url for given search' do
      body = File.open('spec/fixtures/image_search.json')

      stub_request(:get, "https://api.unsplash.com/search/photos?client_id=aNgJTCW3VkD5RH9Hu1aYsx-OqSd7a2P6v8MVVfI-bAw&per_page=1&query=Denver,CO").
         to_return(status: 200, body: body, headers: {})
         
      json = UnsplashApiService.get_image_for_search_query('Denver,CO')
    end
  end
end
