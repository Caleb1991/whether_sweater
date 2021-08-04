class Api::V1::ForecastsController < ApplicationController
  def index
    if params[:location] && params[:location].class == String
      forecast = OpenWeatherFacade.create_weather_object(params[:location])
      render json: ForecastSerializer.send_weather_package(forecast)
    end
  end
end
