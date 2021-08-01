class WeatherPackage
  attr_reader :date_time,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(json)
    @date_time = date_time_calculation(json)
  end

  def date_time_calculation(json)
    DateTime.strptime(json[:current][:dt].to_s, '%s')
  end
end
