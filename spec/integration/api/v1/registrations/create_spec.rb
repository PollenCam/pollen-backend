require 'rails_helper'

RSpec.describe "Api::V1::Registrations::Creates", type: :request do
  describe "POST /api/v1/registrations" do
    it "registers the user" do
      post api_v1_registrations_path
      expect(response).to have_http_status(:ok)
    end
  end
end
