require 'rails_helper'

RSpec.describe 'User API' do
  it 'creates a user' do
    json_payload = {
      email: 'Roald91',
      password: 'IceCold',
      password_confirmation: 'IceCold'
      }

    post '/api/v1/users', params: json_payload, as: :json

    expect(response).to be_successful

    request_body = JSON.parse(request.body.read, symbolize_names: true)

    expect(request_body[:email]).to eq('Roald91')
    expect(request_body[:password]).to eq('IceCold')
    expect(request_body[:password_confirmation]).to eq('IceCold')

    user = User.last

    expect(user.email).to eq('Roald91')
    expect(user.password_digest).to be_a(String)
    expect(user.api_key).to be_a(String)
  end

  it 'can catch password errors' do
    json_payload = {
      email: 'Roald91',
      password: 'IceCold',
      password_confirmation: 'IceCod'
      }

    post '/api/v1/users', params: json_payload, as: :json

    expect(response).to_not be_successful

    error_message = JSON.parse(response.body, symbolize_names: true)

    expect(error_message[:data][:attributes][:errors]).to eq(["Password confirmation doesn't match Password"])
    expect(error_message[:data][:attributes]).to_not have_key([:email])
    expect(error_message[:data][:attributes]).to_not have_key([:api_key])
  end

end
