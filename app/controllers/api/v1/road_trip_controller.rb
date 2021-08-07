class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: road_trip_attributes[:api_key])

    if user
      road_trip_object = RoadTripFacade.plan_road_trip(road_trip_attributes)

      if road_trip_object.travel_time.nil?
        render json: RoadTripSerializer.invalid_destination(road_trip_object)
      else
        render json: RoadTripSerializer.valid_destination(road_trip_object)
      end

    else
      render json: ErrorSerializer.invalid_api_key, status: 401
    end
  end

  private
  def road_trip_attributes
    JSON.parse(request.body.read, symbolize_names: true)
  end
end
