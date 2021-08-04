class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location]
      image = UnsplashFacade.get_image_url_object(params[:location])
      render json: ImageSerializer.serialize(image, params[:location])
    end
  end
end
