class Api::Rest::EventsController < ApplicationController
  def index
    render json: { events: current_user.events }, status: :ok
  end

  def create
    event = Event.create(owner: current_user)
    event.memberships.create(user: current_user, role: :owner)

    if event.persisted?
      render json: event.attributes, status: :created
    else
      render json: { errors: event.errors }, status: :bad_request
    end
  end
end
