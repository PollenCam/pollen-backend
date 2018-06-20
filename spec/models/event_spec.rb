require 'rails_helper'

describe Event do
  describe "attributes" do
    before(:all) { @event = Event.new }

    attributes = %i{ owner locator }

    attributes.each do |attribute|
      it("responds to ##{attribute}") { @event.send(attribute) }
    end

    describe "relationships" do
      relationships = %i{ memberships users }

      relationships.each do |relationship|
        it("Responds to ##{relationship}") { @event.send(relationship) }
      end
    end
  end

  describe "relationships" do
    # Considering breaking complex relationship specs into their own file
    let(:owner) { FactoryBot.create(:user) }
    let(:event) { Event.new(owner: owner) }

    it 'belongs to owner' do
      expect(event.owner).to be owner
    end

    it 'has many users' do
      users = FactoryBot.create_list(:user, 3)
      Membership.create(users.map {|user| Hash[user: user, event: event] })
      expect(event.users).to eq users
    end
  end

  describe "locator" do
    before(:all) do
      @rando = FactoryBot.create(:user)
      FactoryBot.create(:event, owner: @rando, locator: '12345')
    end

    let(:event) { FactoryBot.build(:event, locator: nil) }

    it 'has a unique locator' do
      event.locator = '12345'
      expect(event.valid?).to be false # Ugh, I hate having multiple layers of validations
      expect { event.save(validate: false) }.to raise_error ActiveRecord::RecordNotUnique
    end

    describe "#assign_locator" do
      it 'assigns a locator' do
        expect { event.assign_locator }.to change { event.locator }
      end

      context "with locator collisions" do
        before do
          # FactoryBot.create(:event, owner: @rando, locator: '12345') # This is done in a previous before block
          FactoryBot.create(:event, owner: @rando, locator: '23456')
          FactoryBot.create(:event, owner: @rando, locator: '34567')

          allow_any_instance_of(Event).to receive(:generate_locator).and_return('12345', '23456', '34567', '45678')
        end

        it 'assigns a unique locator token' do
          event.assign_locator
          expect(event.locator).to eq '45678'
        end
      end
    end
  end
end
