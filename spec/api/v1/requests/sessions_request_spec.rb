require 'rails_helper'

RSpec.describe 'Sessions API' do
  describe 'create' do
    xit 'logs a user in' do
      post '/api/v1/sessions'

      expect(response).to be_successful
    end
  end
end
