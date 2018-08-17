require 'rails_helper'

RSpec.describe "Api::Rest::PresignedUrls#create", type: :request do
  describe "POST /api/rest/events/:event_id/images" do
    def post_with_params
      post(api_rest_images_path, params: image_params, headers: { 'X-AUTH-TOKEN': current_user.auth_token }, as: :json)
    end

    let(:ownership) { FactoryBot.create(:membership, role: :owner) }
    let(:current_user) { ownership.user }
    let(:event) { ownership.event }
    let(:target_event) { event }
    let(:image_params) { Hash[event_id: target_event.id] }

    it "creates an image" do
      expect { post_with_params }.to change { Image.count }.by 1
    end

    context "without membership" do
      let(:other_membership) { FactoryBot.create(:membership, role: :owner) }
      let(:other_user) { other_membership.user }
      let(:target_event) { other_membership.event }

      it "cannot add an image" do
        post_with_params
        expect(response).to_not be_successful
        expect(response.status_message).to eq 'Unauthorized'
      end

      context "as attendee" do
        before { FactoryBot.create(:membership, role: :attendee, event: target_event, user: current_user) }

        it "can add an image" do
          post_with_params
          expect(response).to be_successful
          expect(response.status_message).to eq 'Created'
        end
      end
    end

    it "returns a pre-signed url" do
      post_with_params

      uri = URI.parse response_json['image']['presigned_url']

      expect(uri.scheme).to eq 'https'
      expect(uri.host).to include 'amazonaws'
    end

    it "expires in 3 days" do
      post_with_params

      uri = URI.parse response_json['image']['presigned_url']
      query_params = Rack::Utils.parse_nested_query uri.query

      expect(query_params['X-Amz-Expires']).to eq "#{3.days.to_i}"
    end
  end
end
