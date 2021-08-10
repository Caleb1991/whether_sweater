require 'rails_helper'

RSpec.describe Coordinates do
  describe 'initialize' do
    it 'exists' do
      attributes = [{locations:[
        {
          latLng:{
            lat: 132.55,
            lng: -442.44
          }
        }
      ]
      }]

      example = Coordinates.new(attributes)

      expect(example).to be_a(Coordinates)
    end

    it 'has attributes' do
      attributes = [{locations:[
        {
          latLng:{
            lat: 132.55,
            lng: -442.44
          }
        }
      ]
      }]

      example = Coordinates.new(attributes)

      expect(example.latitude).to eq(132.55)
      expect(example.longitude).to eq(-442.44)
    end
  end
end
