require 'rails_helper'

RSpec.describe 'User API' do
  it 'creates a user' do
    json_payload = {
      username: 'Roald91',
      password: 'IceCold',
      password_confirmation: 'IceCold'
      }

    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    post '/api/v1/users', headers: headers, params: json_payload.to_json, as: :json

    expect(response).to be_successful

    user = User.last

    expect(user.username).to eq('Roald')
    expect(user.password).to be_a(String)
  end
end
