# frozen_string_literal: true
require 'pry'
RSpec.describe TinkoffClient do
  it "has a version number" do
    expect(TinkoffClient::VERSION).not_to be nil
  end

  it "should TinkoffClient.configure work and configuration not to be nil" do
    TinkoffClient.configure do |c|
			c.cert = File.read("./open-api-cert.pem")
			c.pkey = File.read("./private.key")
			c.terminal_key = ENV['TERMINAL_KEY']
			c.terminal_secret = ENV['TERMINAL_SECRET']
		end

    expect(TinkoffClient.configuration.cert).not_to be nil
    expect(TinkoffClient.configuration.pkey).not_to be nil
  end
end
