# frozen_string_literal: true

require 'json'
require 'rest-client'
require 'openssl'
require 'base64'

module TinkoffClient
	module CardData

		def encrypt_data(keys)
    card = keys[:Card]
    concatenated = card.map{|k,v| [k,v].join("=")}.join(";")
    public_key = OpenSSL::PKey::RSA.new TinkoffClient.configuration.payment_public_key
    card_data = Base64.encode64(public_key.public_encrypt(concatenated))
		end

	end
end
 