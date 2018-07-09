require 'rails_helper'

RSpec.describe "Api::Rest::UserAccounts#sign_in", type: :request do
  describe "POST /api/rest/user_accounts/sign_in" do
    def post_with_params
      post(sign_in_api_rest_user_accounts_path, params: account_params, as: :json)
    end

    let(:user) { FactoryBot.create(:user) }
    let(:account_params) { Hash[user_account: { email: user.email, password: 'password' }] }

    it 'does not require authentication' do
      post_with_params
      expect(request.headers['X-AUTH-TOKEN']).to be_nil
      expect(response).to be_successful
    end

    context "when given correct login information" do
      it "returns user attributes" do
        post_with_params
        expect(response_json).to eq('auth_token' => user.auth_token)
      end
    end

    context "when given incorrect login information" do
      it "returns errors" do
        account_params[:user_account][:password] = 'incorrect'
        post_with_params
        expect(response).to be_unauthorized
        expect(response_json['errors']['login']).to include 'Bad password or email address'
      end
    end
  end
end
