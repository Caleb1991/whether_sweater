class UserSerializer
  include FastJsonapi::ObjectSerializer

  def self.user_creation(user)
    { data:
      { id: user.id,
        type: 'user',
        attributes:
        {
          email: user.email,
          api_key: user.api_key
        }

      }

    }
  end

  def self.login_user(user)
    { data:
      { id: user.id,
        type: 'user',
        attributes:
        {
          email: user.email,
          api_key: user.api_key
        }

      }

    }
  end
end
