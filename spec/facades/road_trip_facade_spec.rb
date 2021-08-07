require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'plan_road_trip' do
    it 'returns a road trip object' do
      WebMock.allow_net_connect!

      attributes = {
        origin: 'denver,CO',
        destination: 'Phoenix,AZ'
      }

      road_trip = RoadTripFacade.plan_road_trip(attributes)
    end
  end
end
