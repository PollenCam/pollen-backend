require 'rails_helper'

describe User do
  it 'is devise-y' do
    expect(User.devise_modules).to eq %i{
      database_authenticatable
      rememberable
      recoverable
      registerable
      validatable
      confirmable
      lockable
      timeoutable
      trackable
    }
  end

  describe "when new user" do
    it 'has an email' do
      expect(User.new).to respond_to :email
    end

    it 'has a password' do
      expect(User.new).to respond_to :password
    end
  end
end
