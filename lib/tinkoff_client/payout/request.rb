# frozen_string_literal: true

require_relative "../send_request"
require_relative "./encrypt_data"

module TinkoffClient
  module Payout
    class Request
      include SendRequest
      include EncryptData

      attr_reader :url

      def initialize(url)
        @url = "https://securepay.tinkoff.ru/e2c/v2/".freeze
      end

      def self.request(*args, &block)
        params = args[0]
        new(*args, &block).request(path: params[:path], keys: params[:keys])
      end

      def init_params(keys)
        data = encrypt_data(keys)
        payload = {
          TerminalKey: TinkoffClient.configuration.payout_terminal_key,
          SignatureValue: data[:signature_value],
          DigestValue: data[:digest_value],
          X509SerialNumber: data[:x509_serial_number],
          **keys,
        }

      end
    end
  end
end
