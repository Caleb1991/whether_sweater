class Api::V1::ForecastsController < ApplicationController
  def index
    if params[:location] && params[:location].class == String
      render json: ForecastSerializer.send_weather_package(OpenWeatherFacade.create_weather_object(params[:location]))
    end
  end
end
