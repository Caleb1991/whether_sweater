class RoadTrip
  attr_reader :origin,
              :destination,
              :travel_time,
              :temperature,
              :conditions

  def initialize(origin, destination, weather_at_eta, travel_time)
    @origin = origin
    @destination = destination
    @travel_time = travel_time_helper(travel_time)
    @temperature = temperature_helper(weather_at_eta, travel_time)
    @conditions = conditions_helper(weather_at_eta, travel_time)
  end

  def temperature_helper(weather_attributes, travel_time)
    weather_attributes[:hourly][travel_time.arrival_time.to_f.to_i][:temp]
  end

  def conditions_helper(weather_attributes, travel_time)
    weather_attributes[:hourly][travel_time.arrival_time.to_f.to_i][:weather][0][:description]
  end

  def travel_time_helper(travel_time)
    if travel_time.arrival_time
      travel_time.arrival_time.split(':')
    else
      travel_time.arrival_time
    end
  end
end
