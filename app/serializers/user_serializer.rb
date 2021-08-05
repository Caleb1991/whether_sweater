class UserSerializer
  def self.user_creation(user)
    { data:
      { id: user.id,
        type: 'user',
        attributes:
        {
          email: user.username,
          api_key: user.api_key
        }

      }

    }
  end
end
