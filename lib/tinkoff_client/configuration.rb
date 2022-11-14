# frozen_string_literal: true

module TinkoffClient
  class Configuration
    attr_accessor :payment_public_key, :payment_terminal_key, :payment_terminal_secret

    def initialize
      @payment_public_key = nil
      @payment_terminal_key = nil
      @payment_terminal_secret = nil
    end

  end
end