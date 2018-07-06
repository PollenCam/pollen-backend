module Requests
  module JsonHelpers
    def response_json
      JSON.parse(response.body)
    end

    # def status_code_for sym
    #   Rack::Utils::SYMBOL_TO_STATUS_CODE[sym]
    # end
  end
end
