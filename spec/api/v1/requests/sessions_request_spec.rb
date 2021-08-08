require 'rails_helper'

RSpec.describe 'Sessions API' do
  describe 'create' do
    before :each do
      json_payload = {
        email: 'Roald91',
        password: 'IceCold',
        password_confirmation: 'IceCold'
        }

      post '/api/v1/users', params: json_payload, as: :json
    end

    it 'logs a user in' do
      post '/api/v1/sessions', params: {email: 'Roald91', password: 'IceCold'}, as: :json

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:attributes][:email]).to eq('Roald91')
      expect(json[:data][:attributes][:api_key]).to eq(User.last.api_key)
    end

    it "doesn't log a user in if bad credentials" do
      post '/api/v1/sessions', params: {email: 'Roald91', password: 'Iceold'}, as: :json

      expect(response).to_not be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:attributes][:errors]).to eq("Your password or email is incorrect.")
    end
  end
end
