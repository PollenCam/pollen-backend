require 'rails_helper'

RSpec.describe "Api::Rest::Events#create", type: :request do
  describe "POST /api/rest/events" do
    def post_with_params
      post(api_rest_events_path, headers: { 'X-AUTH-TOKEN': owner.auth_token })
    end

    context "with owner" do
      let(:owner) { FactoryBot.create(:user) }

      it 'creates an event' do
        expect { post_with_params }.to change { Event.count }.by 1
      end

      it 'has a locator' do
        post_with_params
        expect(response_json).to include "locator"
        expect(response_json["locator"]).to be_present
      end
    end
  end
end
