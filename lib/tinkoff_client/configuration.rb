# frozen_string_literal: true

module TinkoffClient
  class Configuration
    attr_accessor :payment_public_key, :payment_terminal_key, :payment_terminal_secret,
                  :payout_terminal_key, :payout_terminal_secret, :payout_certificate, :payout_private_key

    def initialize
      @payment_public_key = nil
      @payment_terminal_key = nil
      @payment_terminal_secret = nil

      @payout_terminal_key = nil
      @payout_terminal_secret = nil
      @payout_certificate = nil
      @payout_private_key = nil
    end
  end
end
