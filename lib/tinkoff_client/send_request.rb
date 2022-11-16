# frozen_string_literal: true

require "json"
require "rest-client"

module TinkoffClient
  module SendRequest
    def request(path:, keys:)
      url = @url + path
      payload = init_params(keys).to_json
      result = RestClient.post(url, payload, content_type: :json)
      data = JSON.parse result.body
    end
  end
end
