class User < ApplicationRecord
  validates_presence_of :username, :password, :password_confirmation
end
