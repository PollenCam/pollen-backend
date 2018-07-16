require 'rails_helper'

class TestApplicationsController < ApplicationController
  def show(*) end
end

RSpec.describe TestApplicationsController, type: :request do
  before do
    Rails.application.routes.append { resource :test_application, only: :show }
    Rails.application.reload_routes!
  end

  let(:user) { FactoryBot.create(:user) }

  describe "GET authenticated JSON endpoint" do
    context "without headers CONTENT_TYPE and ACCEPT as application/json" do
      it "returns Not Acceptable" do
        get(test_application_path)

        http_406 = Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_acceptable]

        expect(response.status).to be http_406
        expect(response.status_message).to match /Not Acceptable/
      end
    end

    context "with headers CONTENT_TYPE and ACCEPT as application/json" do
      context "without authentication token" do
        it "returns unauthorized" do
          get(test_application_path, as: :json)
          expect(response).to be_unauthorized
        end
      end

      context "with authentication token" do
        it 'returns 2xx success' do
          get(test_application_path, headers: { 'X-AUTH-TOKEN': user.auth_token }, as: :json)
          expect(response).to be_successful
        end
      end
    end
  end
end
