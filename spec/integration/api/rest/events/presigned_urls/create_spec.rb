require 'rails_helper'

RSpec.describe "Api::Rest::PresignedUrls#create", type: :request do
  describe "POST /api/rest/presigned_urls" do
    def post_with_params
      post(api_rest_presigned_urls_path, headers: { 'X-AUTH-TOKEN': owner.auth_token }, as: :json)
    end

    let(:ownership) { FactoryBot.create(:membership, role: :owner) }
    let(:owner) { ownership.user }

    it "returns a pre-signed url" do
      post_with_params

      uri = URI.parse response_json['presigned_url']

      expect(uri.scheme).to eq 'https'
      expect(uri.host).to include 'pollencam-user-uploads'
      expect(uri.host).to include 'amazonaws'
    end

    it "expires in 3 days" do
      post_with_params

      uri = URI.parse response_json['presigned_url']
      query_params = Rack::Utils.parse_nested_query uri.query

      expect(query_params['X-Amz-Expires']).to eq "#{3.days.to_i}"
    end
  end
end
