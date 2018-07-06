class Api::Rest::UserAccountsController < ApplicationController
  skip_before_action :authenticate_user_from_token!

  def create
    user = User.create(user_account_params)

    if user.persisted?
      render json: user.attributes.slice(*%w{auth_token email}), status: :created
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end

  def sign_in
    user = User.find_by(email: params[:user_account][:email])

    if user.valid_password?(params[:user_account][:password])
      render json: { auth_token: user.auth_token}, status: :ok
    else
      render json: { errors: { login: ['Bad password or email address'] } }, status: :unauthorized
    end
  end

  private

  def user_account_params
    params.require(:user_account).permit(:email, :password)
  end
end
