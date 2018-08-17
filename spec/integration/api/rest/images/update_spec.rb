require 'rails_helper'

RSpec.describe "Api::Rest::PresignedUrls#create", type: :request do
  describe "POST /api/rest/events/:event_id/images" do
    def put_with_params target_event=event
      put(api_rest_event_images_path(target_event, image), headers: { 'X-AUTH-TOKEN': current_user.auth_token }, as: :json)
    end

    let(:membership) { FactoryBot.create(:membership, role: :owner) }
    let(:current_user) { ownership.user }
    let(:event) { ownership.event }
    let(:image) { FactoryBot.create(:image, membership: membership) }

    it 'updates final_url' do
      # put_with_params
    end
  end
end
