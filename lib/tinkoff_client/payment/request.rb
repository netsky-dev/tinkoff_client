# frozen_string_literal: true

require_relative "../send_request"

module TinkoffClient
  module Payment
    class Request
      include SendRequest

      attr_reader :url

      def initialize(url)
        @url = "https://securepay.tinkoff.ru/v2/".freeze
      end

      def self.request(*args, &block)
        params = args[0]
        new(*args, &block).request(path: params[:path], keys: params[:keys])
      end

      def init_params(keys)
        payload = {
          TerminalKey: TinkoffClient.configuration.payment_terminal_key,
          Password: TinkoffClient.configuration.payment_terminal_secret,
          **keys,
        }

        payload[:Token] = generate_token(payload)
        payload.except(:Password)
      end

      def generate_token(keys)
        params = keys.except(:Receipt, :Shops, :DATA).sort.transpose[1].join
        digest = Digest::SHA2.new(256).hexdigest params
      end
    end
  end
end
