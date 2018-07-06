# Stolen from https://blog.maestrano.com/rails-api-authentication-with-warden-without-devise/
class ApiFailureApp < Devise::FailureApp
  def self.call(env)
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    self.response_body = { error: "Please authenticate with a valid token" }.to_json
    self.status = :unauthorized
  end
end
