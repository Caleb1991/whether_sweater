class UnsplashFacade

  def self.get_image_url_object(search_params)
    image_attributes = UnsplashApiService.get_image_for_search_query(search_params)

    ImageUrl.new(image_attributes)
  end
end
