require 'rails_helper'

class AuthenticationTestsController < ApplicationController
  def index(*) end

  before_action :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    user = request.headers['X-AUTH-TOKEN']
                  .presence
                  .yield_self do |token|
                    token && User.find_by(auth_token: token.to_s)
                  end

    sign_in(user, store: false) if user
    authenticate_user!
  end

end

RSpec.describe "AuthenticationTest", type: :request do
  before do
    Rails.application.routes.append { resources :authentication_tests }
    Rails.application.reload_routes!
  end

  describe "GET authenticated endpoint" do
    context "without authentication token" do
      it "returns unauthorized" do
        get(authentication_tests_path)
        expect(response).to be_unauthorized
      end
    end

    context "with authentication token" do
      let(:user) { FactoryBot.create(:user) }

      it 'returns user data' do
        get(authentication_tests_path, headers: { 'X-AUTH-TOKEN' => user.auth_token })
        expect(response).to be_successful
      end
    end
  end
end
