class ErrorSerializer
  include FastJsonapi::ObjectSerializer

  def self.registration_error(errors)
    {data:
      { id: nil,
        type: 'error(s)',
        attributes:{
          errors: errors
        }

      }
    }
  end

  def self.login_error
    { data:
      { id: nil,
        type: 'error(s)',
        attributes:
        { errors: 'Your password or email is incorrect.'

        }

      }

    }
  end

  def self.invalid_api_key
    { data:
      {
        id: nil,
        type: 'error(s)',
        attributes:
        {
          errors: 'Your api key is invalid'
        }
      }
    }
  end
end
