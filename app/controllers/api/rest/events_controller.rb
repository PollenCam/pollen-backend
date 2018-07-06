class Api::Rest::EventsController < ApplicationController
  def create
    event = Event.create(owner: current_user)

    if event.persisted?
      render json: event.attributes, status: :created
    else
      render json: { errors: event.errors }, status: :bad_request
    end
  end
end
