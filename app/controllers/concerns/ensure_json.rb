require 'active_support/concern'

module EnsureJson
  extend ActiveSupport::Concern

  included do
    prepend_before_action :ensure_json

    private

    def ensure_json
      head :not_acceptable unless request.format == :json
    end
  end
end
