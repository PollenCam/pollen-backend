require 'active_support/concern'

module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user_from_token!

    private

    def authenticate_user_from_token!
      user = request.headers['X-AUTH-TOKEN']
                    .presence
                    .yield_self do |token|
                      token && User.find_by(auth_token: token.to_s)
                    end

      sign_in(user, store: false) if user
      authenticate_user!
    end
  end
end
