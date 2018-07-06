class Api::Rest::MembershipsController < ApplicationController
  def create
    membership = Membership.create(membership_params.merge(user: current_user))

    if membership.persisted?
      render json: membership.attributes, status: :created
    else
      render json: { errors: membership.errors }, status: :bad_request
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :event_id)
  end
end
