class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_attributes)

    if user.save
      user.update(api_key: SecureRandom.alphanumeric(16))
      render json: UserSerializer.user_creation(user)
    else
      render json: { error: user.errors.full_messages }
    end
  end

  private
  def user_attributes
    JSON.parse(request.body.read, symbolize_names: true)
  end
end
