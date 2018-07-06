class Api::Rest::UserAccountsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: :create

  def create
    user = User.create(user_account_params)

    if user.persisted?
      render json: user.attributes.slice(*%w{auth_token email}), status: :created
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end

  private

  def user_account_params
    params.require(:user_account).permit(:email, :password)
  end
end
