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

  describe "attributes" do
    before(:all) { @user = User.new }

    attributes = %w{ email password auth_token full_name }

    attributes.each do |attribute|
      it("responds to ##{attribute}") { @user.send(attribute) }
    end

    it 'has a full_name' do
      User.new.full_name
    end
  end
end
