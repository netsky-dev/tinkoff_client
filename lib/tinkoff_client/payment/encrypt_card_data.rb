# frozen_string_literal: true

require "openssl"
require "base64"

module TinkoffClient
  module Payment
    module EncryptCardData
      def encrypt_data(keys)
        card = keys[:Card]
        concatenated = card.map { |k, v| [k, v].join("=") }.join(";")
        public_key = OpenSSL::PKey::RSA.new File.read(TinkoffClient.configuration.payment_public_key)
        card_data = Base64.encode64(public_key.public_encrypt(concatenated))
      end
    end
  end
end
