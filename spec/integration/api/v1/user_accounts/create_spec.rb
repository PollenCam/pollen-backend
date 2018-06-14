require 'rails_helper'

RSpec.describe "Api::V1::UserAccounts#create", type: :request do
  describe "POST /api/v1/user_accounts" do
    let(:account_params) { Hash[user_account: { email: 'test@example.com', password: 'password' }] }
    let(:post_with_params) { post(api_v1_user_accounts_path, params: account_params) }

    it "registers the user" do
      post_with_params
      expect(response).to have_http_status(:created)
    end

    it 'creates a new User' do
      expect { post_with_params }.to change { User.count }.by 1
    end

    it 'returns json' do
      post_with_params
      expect { response_json }.to_not raise_error
    end

    it 'returns an auth token' do
      post_with_params
      expect(response_json).to have_key "auth_token"
    end

    it 'returns a different auth token for each user' do
      post_with_params
      first_token = response_json['auth_token']

      account_params[:user_account][:email] = FactoryBot.generate(:email)
      post_with_params
      second_token = response_json['auth_token']

      expect(first_token).to_not eq second_token
    end
  end
end
