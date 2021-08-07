class Route
  attr_reader :arrival_time

  def initialize(attributes)
    @arrival_time = attributes[:route][:formattedTime]
  end
end
