class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_attributes[:email])

    if user && user.authenticate(user_attributes[:password])
      render json: UserSerializer.login_user(user)
    else
      render json: ErrorSerializer.login_error, status: 401
    end
  end

  private
  def user_attributes
    JSON.parse(request.body.read, symbolize_names: true)
  end
end
