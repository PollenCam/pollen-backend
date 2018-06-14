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
      User.new.email
    end

    it 'has a password' do
      User.new.password
    end

    it 'has an auth_token' do
      User.new.auth_token
    end

    it 'has a full_name' do
      User.new.full_name
    end
  end
end
