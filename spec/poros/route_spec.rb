require 'rails_helper'

RSpec.describe Route do
  describe 'initialize' do
    it 'exists' do
      route_attributes = {
        route:{
          formattedTime: '12:30'
        }
      }

      example = Route.new(route_attributes)

      expect(example).to be_a(Route)
    end

    it 'has attributes' do
      route_attributes = {
        route:{
          formattedTime: '12:30'
        }
      }

      example = Route.new(route_attributes)

      expect(example.arrival_time).to eq('12:30')
    end
  end
end
