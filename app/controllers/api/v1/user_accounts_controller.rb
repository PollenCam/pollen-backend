class Api::V1::UserAccountsController < ApplicationController
  def create
    User.create!(user_account_params)
    render status: :created
  end

  private

  def user_account_params
    params.require(:user_account).permit(:email, :password)
  end
end
