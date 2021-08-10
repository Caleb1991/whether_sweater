require 'rails_helper'

RSpec.describe ImageUrl do
  describe 'initialize' do
    it 'exists' do
      image_attributes = {
        results:[
          {
            urls:{
              full: 'https://test.com'
            }
          }
        ]
      }

      example = ImageUrl.new(image_attributes)

      expect(example).to be_an(ImageUrl)
    end

    it 'has attributes' do
      image_attributes = {
        results:[
          {
            urls:{
              full: 'https://test.com'
            }
          }
        ]
      }

      example = ImageUrl.new(image_attributes)

      expect(example.url).to eq('https://test.com')
    end
  end
end
