require 'rails_helper'

RSpec.describe Image, type: :model do
  describe "relationships" do
    let(:membership) { FactoryBot.create(:membership, role: :owner) }
    let(:image) { FactoryBot.create(:image, membership: membership) }

    it 'belongs to owner' do
      expect(image.membership).to eq membership
    end

    it 'has a user through membership' do
      expect(image.user).to eq membership.user
    end

    it 'has an event through membership' do
      expect(image.event).to eq membership.event
    end
  end
end
