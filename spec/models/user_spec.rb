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
  end

  describe "#token" do
    before(:all) { FactoryBot.create(:user, auth_token: '12345') }

    let(:user) { FactoryBot.build(:user) }

    it 'has a unique auth_token' do
      user.auth_token = '12345'
      expect(user.valid?).to be false # Ugh, I hate having multiple layers of validations
      expect { user.save(validate: false) }.to raise_error ActiveRecord::RecordNotUnique
    end
  end
end
