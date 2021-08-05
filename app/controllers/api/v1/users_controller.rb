class Api::V1::UsersController < ApplicationController
  def create
    user = User.create!(user_attributes)
    if user.save
      render json: UserSerializer.user_creation(user)
    else
      render error: 'One or more attributes is missing'
    end
  end

  private
  def user_attributes
    JSON.parse(params['_json'], symbolize_names: true)
  end
end
