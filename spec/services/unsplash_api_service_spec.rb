require 'rails_helper'

RSpec.describe UnsplashApiService do
  describe 'get_image_for_search_query' do
    it 'returns image url for given search' do
      body = File.open('spec/fixtures/image_search.json')

      stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['unsplash_api_key']}&per_page=1&query=Denver,CO").
         to_return(status: 200, body: body, headers: {})

      response = UnsplashApiService.get_image_for_search_query('Denver,CO')

      expect(response[:results][0][:urls][:full]).to be_a(String)
      expect(response[:results][0][:tags]).to be_an(Array)
    end
  end
end
