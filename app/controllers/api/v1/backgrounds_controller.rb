class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location]
      render json: 'this'
    end
  end
end
