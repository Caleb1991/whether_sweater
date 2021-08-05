require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:password_confirmation)}
  end
end
