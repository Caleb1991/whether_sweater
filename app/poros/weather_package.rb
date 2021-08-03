class WeatherPackage
  attr_reader :current_forecast,
              :five_day_forecast,
              :eight_hour_forecast

  def initialize(current_weather, five_day_weather, eight_hour_weather)
    @current_forecast = current_forecast_calculation(current_weather)
    @five_day_forecast = five_day_forecast_calculation(five_day_weather)
    @eight_hour_forecast = eight_hour_forecast_calculation(eight_hour_weather)
  end

  def date_time_calculation(unix)
    DateTime.strptime(unix.to_s, '%s')
  end

  def current_forecast_calculation(weather_attributes)
    {
      date: date_time_calculation(weather_attributes[:dt]),
      sunrise: date_time_calculation(weather_attributes[:sunrise]),
      sunset: date_time_calculation(weather_attributes[:sunset]),
      temperature: weather_attributes[:temperature],
      feels_like: weather_attributes[:feels_like],
      humidity: weather_attributes[:humidity],
      uvi: weather_attributes[:uvi],
      visibility: weather_attributes[:visibility],
      conditions: weather_attributes[:weather][0][:description],
      icon: weather_attributes[:weather][0][:icon]

    }
  end

  def five_day_forecast_calculation(weather_attributes)
    five_day_weather.map do |day|
      {
        date: date_time_calculation(day[:dt]),
        sunrise: date_time_calculation(day[:sunrise]),
        sunset: date_time_calculation(day[:sunset]),
        high: day[:temp][:max],
        low: day[:temp][:min],
        conditions: day[:weather][0][:description],
        icon: day[:weather][0][:icon]

      }
    end
  end

  def eight_hour_forecast_calculation(weather_attributes)
    eight_hour_weather.map do |hour|
      {
        date: date_time_calculation(hour[:dt]),
        temperature: hour[:temp],
        conditions: hour[:weather][0][:description],
        icon: hour[:weather][0][:icon]
      }
    end
  end
end
