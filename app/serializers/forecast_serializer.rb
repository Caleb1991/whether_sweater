class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  def self.send_weather_package(weather_package)

    {data:
      { id: nil,
        type: 'forecast',
        attributes:
        {
          current_forecast:
            weather_package.current_forecast,
          five_day_forecast:
            weather_package.five_day_forecast,
          eight_hour_forecast:
            weather_package.eight_hour_forecast
        }
      }
    }
  end
end
