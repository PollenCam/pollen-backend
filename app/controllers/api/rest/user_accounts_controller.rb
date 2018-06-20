class Api::Rest::UserAccountsController < ApplicationController
  def create
    user = User.create(user_account_params)

    if user.persisted?
      render json: user.attributes, status: :created
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end

  private

  def user_account_params
    params.require(:user_account).permit(:email, :password)
  end
end
