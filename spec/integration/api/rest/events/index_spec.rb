require 'rails_helper'

RSpec.describe "Api::Rest::Events#index", type: :request do
  describe "GET /api/rest/events" do
    context "with owned event and subscribed event" do
      it 'returns both events' do
        owner, friend = FactoryBot.create_list(:user, 2)
        owners_event  = FactoryBot.create(:event, owner: owner)
        friends_event = FactoryBot.create(:event, owner: friend)
        membership    = FactoryBot.create(:membership, event: friends_event, user: owner)

        get api_rest_events_path, headers: { 'X-AUTH-TOKEN': owner.auth_token }

        expect(response_json['events'].length).to eq 2
      end
    end
  end
end