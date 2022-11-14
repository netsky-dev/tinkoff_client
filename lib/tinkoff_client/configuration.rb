# frozen_string_literal: true

module TinkoffClient
  class Configuration
    attr_accessor :cert, :pkey, :terminal_key, :terminal_secret

    def initialize
      @cert = nil
      @pkey = nil
      @terminal_key = nil
      @terminal_secret = nil
    end
    
  end
end