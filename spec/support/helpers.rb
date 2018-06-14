require 'helpers/request_helpers'

RSpec.configure do |config|
  config.include Requests::JsonHelpers, type: :request
end
