require 'rails_helper'

RSpec.describe "Api::Rest::Events#index", type: :request do
  describe "GET /api/rest/events" do
    context "with owned event and subscribed event" do
      it 'returns both events' do
        owner, friend = FactoryBot.create_list(:user, 2)
        owners_event, friends_event  = FactoryBot.create_list(:event, 2)
        ownership     = FactoryBot.create(:membership, event: owners_event, user: owner, role: :owner)
        membership    = FactoryBot.create(:membership, event: friends_event, user: owner)

        get api_rest_events_path, headers: { 'X-AUTH-TOKEN': owner.auth_token }, as: :json

        expect(response_json['events'].length).to eq 2
      end
    end
  end
end
