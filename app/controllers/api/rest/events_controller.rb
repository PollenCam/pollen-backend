class Api::Rest::EventsController < ApplicationController
  def create
    event = Event.create(event_params)

    if event.persisted?
      render json: { locator: event.locator }, status: :created
    else
      render json: { errors: event.errors }, status: :bad_request
    end
  end

  private

  def event_params
    params.require(:event).permit(:owner_id)
  end
end
