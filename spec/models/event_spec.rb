require 'rails_helper'

describe Event do
  describe "attributes" do
    before(:all) { @event = Event.new }

    attributes = %w{ owner locator }

    attributes.each do |attribute|
      it("responds to ##{attribute}") { @event.send(attribute) }
    end
  end

  describe "relations" do
    let(:owner) { FactoryBot.create(:user) }
    let(:event) { Event.new(owner: owner) }

    it 'belongs to Users' do
      expect(event.owner).to be owner
    end
  end
end
