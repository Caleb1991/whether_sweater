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
end
