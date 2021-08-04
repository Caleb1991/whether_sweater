class ImageUrl
  attr_reader :url

  def initialize(json)
    @url = json[:results][0][:urls][:full]
  end
end
