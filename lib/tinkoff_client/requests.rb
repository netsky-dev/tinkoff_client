# frozen_string_literal: true

require 'json'
require 'rest-client'

module TinkoffClient
	module Requests

		def request(path:, keys:)						
			url = @url + path
			payload = init_params(keys).to_json			
			result = RestClient.post(url, payload, content_type: :json)
			data = JSON.parse result.body
		end

		def init_params(keys)
			payload = {
				TerminalKey: TinkoffClient.configuration.payment_terminal_key,     
				Password: TinkoffClient.configuration.payment_terminal_secret, 
				**keys
   }
			
			payload[:Token] = generate_token(payload)
			payload.except(:Password)
		end


	end
end

