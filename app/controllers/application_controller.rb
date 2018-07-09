class ApplicationController < ActionController::API
  include TokenAuthenticatable
  prepend_before_action :ensure_json

  private

  def ensure_json
    head :not_acceptable unless request.format == :json
  end
end
