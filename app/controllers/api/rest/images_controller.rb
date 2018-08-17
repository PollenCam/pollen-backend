class Api::Rest::ImagesController < ApplicationController
  def create
    membership = current_user.memberships.find_by(event_id: params['event_id'], role: :owner)
    return render(status: :unauthorized) if membership.nil?

    image = Image.create(presigned_url: PresignedUrl.generate, membership: membership)
    render json: { image: image }, status: :created
  end
end
