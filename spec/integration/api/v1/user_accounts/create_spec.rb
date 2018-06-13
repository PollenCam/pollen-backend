require 'rails_helper'

RSpec.describe "Api::V1::UserAccounts#create", type: :request do
  describe "POST /api/v1/user_accounts" do
    let(:account_params) { Hash[user_account: { email: 'test@example.com', password: 'password' }] }

    it "registers the user" do
      post api_v1_user_accounts_path, params: account_params
      expect(response).to have_http_status(:created)
    end

    it 'creates a new User' do
      expect { post api_v1_user_accounts_path, params: account_params }.to change { User.count }.by 1
    end
  end
end
