class Api::V1::ForecastsController < ApplicationController
  def index
    if params[:location] && params[:location].class == String && params[:location] != ""
      forecast = OpenWeatherFacade.create_weather_object(params[:location])
      render json: ForecastSerializer.send_weather_package(forecast)
    else
      render json: ErrorSerializer.invalid_location
    end
  end
end
