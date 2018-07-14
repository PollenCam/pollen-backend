require 'rails_helper'

describe Event do
  describe "attributes" do
    before(:all) { @event = Event.new }

    attributes = %i{ locator }

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
    let(:event) { Event.create }

    it 'belongs to owner' do
      FactoryBot.create(:membership, event: event, user: owner, role: :owner)
      expect(event.owner).to eq owner
    end

    it 'has many users' do
      users = FactoryBot.create_list(:user, 3)
      users.each do |user|
        FactoryBot.create(:membership, user: user, event: event)
      end

      expect(event.users).to match_array users
    end
  end

  describe "locator" do
    before(:all) do
      @rando = FactoryBot.create(:user)
      event = FactoryBot.create(:event, locator: '1234')
      membership = FactoryBot.create(:membership, event: event, user: @rando, role: :owner)
    end

    let(:event) { FactoryBot.build(:event) }

    it 'has a unique locator' do
      event.locator = '1234'
      expect(event.valid?).to be false # Ugh, I hate having multiple layers of validations
      expect { event.save(validate: false) }.to raise_error ActiveRecord::RecordNotUnique
    end

    it 'is four digits long' do
      expect(event.locator.length).to eq 4
    end

    describe "#assign_locator" do
      let(:event) { FactoryBot.build(:event) }

      it 'assigns a locator' do
        expect { event.assign_locator }.to change { event.locator }
      end

      context "with locator collisions" do
        before do
          # FactoryBot.create(:event, owner: @rando, locator: '12345') # This is done in a previous before block
          e1 = FactoryBot.create(:event, locator: '2345')
          e2 = FactoryBot.create(:event, locator: '3456')
          FactoryBot.create(:membership, event: e1, user: @rando, role: :owner)
          FactoryBot.create(:membership, event: e2, user: @rando, role: :owner)

          allow_any_instance_of(Event).to receive(:generate_locator).and_return('1234', '2345', '3456', '4567')
        end

        it 'assigns a unique locator token' do
          event.assign_locator
          expect(event.locator).to eq '4567'
        end
      end

      context "with cuss words in locator" do
        before do
          allow_any_instance_of(Event)
            .to receive(:generate_locator)
            .and_return('FUCK', 'CUNT', 'ASS1', '4567')
        end

        it 'assigns a tame locator token' do
          expect(event.locator).to eq '4567'
        end
      end
    end
  end

  describe "#policy" do
    let(:event) { FactoryBot.create(:event) }

    it 'is an EventPolicy' do
      expect(event.policy).to be_a EventPolicy
    end

    it "has a start_time of the event's creation time" do
      expect(event.policy.start_time).to eq event.created_at
    end

    describe "#can_upload?" do
      it 'delegates to its policy' do
        expect(event.policy).to receive :can_upload?
        event.can_upload?
      end

      it 'is the same as its policy' do
        expect(event.can_upload?).to eq event.policy.can_upload?
      end

      context "with the passing of time" do
        before { Timecop.freeze(event.created_at) }

        after { Timecop.return }

        it 'can upload after exactly 24 hours' do
          Timecop.freeze(24.hours.from_now)

          expect(event.can_upload?).to be true
        end

        it 'cannot upload after more than 24 hours' do
          Timecop.freeze(24.hours.from_now + 1)
          expect(event.can_upload?).to be false
        end
      end
    end

    describe "#can_download?" do
      it 'delegates to its policy' do
        expect(event.policy).to receive :can_download?
        event.can_download?
      end

      it 'is the same as its policy' do
        expect(event.can_download?).to eq event.policy.can_download?
      end

      context "with the passing of time" do
        before { Timecop.freeze(event.created_at) }

        after { Timecop.return }

        it 'can download after exactly 14 days' do
          Timecop.freeze(14.days.from_now)

          expect(event.can_download?).to be true
        end

        it 'cannot download after more than 14 days' do
          Timecop.freeze(14.days.from_now + 1)
          expect(event.can_download?).to be false
        end

        context "with payment" do
          it 'can download after 14 days' do
            Timecop.freeze(14.days.from_now + 1)
            event.policy.payment_at = Time.now
            expect(event.can_download?).to be true
          end

          it 'can download 30 days after payment' do
            Timecop.freeze(14.days.from_now + 1)
            event.policy.payment_at = Time.now
            Timecop.freeze(30.days.from_now)
            expect(event.can_download?).to be true
          end

          it 'cannot download just after 30 days post-payment' do
            Timecop.freeze(14.days.from_now + 1)
            event.policy.payment_at = Time.now
            Timecop.freeze(30.days.from_now + 1)
            expect(event.can_download?).to be false
          end
        end
      end
    end

    context "when Event not persisted" do
      let(:event) { FactoryBot.build(:event) }

      it 'does not raise error' do
        expect { event.policy }.to_not raise_error
      end
    end
  end
end
