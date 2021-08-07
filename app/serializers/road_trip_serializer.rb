class RoadTripSerializer
  include FastJsonapi::ObjectSerializer

  def self.valid_destination(road_trip_object)
    {data:
      {
        id: nil,
        type: 'road_trip',
        attributes:
        {
          start_city: road_trip_object.origin,
          end_city: road_trip_object.destination,
          travel_time: "#{road_trip_object.travel_time[0]} hours, #{road_trip_object.travel_time[1]} minutes.",
          weather_at_eta:
          {
            temperature: road_trip_object.temperature,
            conditions: road_trip_object.conditions
          }
        }
      }
    }
  end

  def self.invalid_destination(road_trip_object)
    {data:
      {
        id: nil,
        type: 'forecast',
        attributes:
        {
          start_city: road_trip_object.origin,
          end_city: road_trip_object.destination,
          travel_time: 'Impossible destination',
          weather_at_eta:
          {

          }
        }
      }
    }
  end
end
