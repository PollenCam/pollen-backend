require 'rails_helper'

RSpec.describe User do
  it 'is devise-y' do
    expect(User.devise_modules).to eq %i{
      database_authenticatable
      rememberable
      recoverable
      registerable
      validatable

      lockable
      timeoutable
      trackable
    }
  end

  describe "attributes" do
    before(:all) { @user = User.new }

    attributes = %i{ email password auth_token full_name memberships }

    attributes.each do |attribute|
      it("responds to ##{attribute}") { @user.send(attribute) }
    end

    describe "relationships" do
      relationships = %i{ memberships events }

      relationships.each do |relationship|
        it("Responds to ##{relationship}") { @user.send(relationship) }
      end
    end
  end

  describe "auth token" do
    before(:all) { FactoryBot.create(:user, auth_token: '12345') }

    let(:user) { FactoryBot.build(:user, auth_token: nil) }

    it 'has a unique auth_token' do
      user.auth_token = '12345'
      expect(user.valid?).to be false # Ugh, I hate having multiple layers of validations
      expect { user.save(validate: false) }.to raise_error ActiveRecord::RecordNotUnique
    end

    describe "#assign_auth_token" do
      it 'uses Devise#friendly_token' do
        expect(Devise).to receive(:friendly_token)
        user # Thanks to RSpec's lazy evaluation and assign_auth_token being called in initialize...
      end

      it 'assigns an auth token' do
        expect { user.assign_auth_token }.to change { user.auth_token }
      end

      context "with token collisions" do
        before do
          # FactoryBot.create(:user, auth_token: '12345') # This is done in a previous before block
          FactoryBot.create(:user, auth_token: '23456')
          FactoryBot.create(:user, auth_token: '34567')

          allow(Devise).to receive(:friendly_token).and_return('12345', '23456', '34567', '45678')
        end

        it 'assigns a unique auth token' do
          user.assign_auth_token
          expect(user.auth_token).to eq '45678'
        end
      end
    end
  end
end
