class Api::Rest::PresignedUrlsController < ApplicationController
  def create
    render json: { presigned_url: PresignedUrl.generate }, status: :ok
  end
end
