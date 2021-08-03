class UnsplashApiService

  def self.get_image_for_search_query(search_params, per_page = 1)
    response = Faraday.get("https://api.unsplash.com/search/photos") do |req|
      req.params['client_id'] = ENV['unsplash_api_key']
      req.params['per_page'] = per_page
      req.params['query'] = search_params
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
