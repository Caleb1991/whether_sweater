class Coordinates
  attr_reader :latitude,
              :longitude

  def initialize(json)
    @latitude = json[0][:locations][0][:latLng][:lat]
    @longitude = json[0][:locations][0][:latLng][:lng]
  end
end
