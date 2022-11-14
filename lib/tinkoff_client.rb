# frozen_string_literal: true

require_relative "tinkoff_client/version"
require_relative "tinkoff_client/configuration"
require_relative "tinkoff_client/payment/payment"

module TinkoffClient
  class Error < StandardError; end

  include Payment

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
