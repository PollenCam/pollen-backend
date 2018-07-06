require 'rails_helper'

RSpec.describe "Api::Rest::Memberships#create", type: :request do
  describe "POST /api/rest/memberships" do
    def post_with_params
      post(api_rest_memberships_path, params: membership_params, headers: { 'X-AUTH-TOKEN': user.auth_token })
    end

    context "with owner" do
      let(:user) { FactoryBot.create(:user) }
      let(:event) { FactoryBot.create(:event) }
      let(:membership_params) { Hash[membership: { event_id: event.id }] }

      it 'creates a membership' do
        expect { post_with_params }.to change { Membership.count }.by 1
      end

      it 'has attributes' do
        post_with_params

        expect(response_json["user_id"]).to be_present
        expect(response_json["event_id"]).to be_present
        expect(response_json["role"]).to be_present
      end
    end
  end
end
