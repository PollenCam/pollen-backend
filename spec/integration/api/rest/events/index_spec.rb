require 'rails_helper'

RSpec.describe "Api::Rest::Events#index", type: :request do
  def get_events
    get api_rest_events_path, headers: { 'X-AUTH-TOKEN': owner.auth_token }, as: :json
  end

  describe "GET /api/rest/events" do
    let!(:friend_ownership) { FactoryBot.create(:membership, role: :owner) }
    let(:friend_event) { friend_ownership.event }

    let!(:ownership) { FactoryBot.create(:membership, role: :owner) }
    let(:owner) { ownership.user }

    context "when user owns an event" do
      it 'returns owned event' do
        get_events
        expect(response_json['events'].length).to eq 1
      end
    end

    context "when user owns an event and has a membership to another event" do
      it 'returns both events' do
        membership = FactoryBot.create(:membership, event: friend_event, user: owner)
        get_events
        expect(response_json['events'].length).to eq 2
      end
    end
  end
end
