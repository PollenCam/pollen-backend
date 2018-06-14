class Api::V1::UserAccountsController < ApplicationController
  def create
    user = User.create(user_account_params)

    if user.persisted?
      render json: { auth_token: "lololol" }, status: :created
    else
      render json: { errors: user.errors }
    end
  end

  private

  def user_account_params
    params.require(:user_account).permit(:email, :password)
  end
end
