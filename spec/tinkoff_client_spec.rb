# frozen_string_literal: true
require 'pry'
RSpec.describe TinkoffClient do
  before do
		TinkoffClient.configure do |c|
			c.payment_terminal_key = ENV['TERMINAL_KEY']
			c.payment_terminal_secret = ENV['TERMINAL_SECRET']
		end

    @init = TinkoffClient::Payment.init(Amount: "1000", OrderId: rand(1000...2000))
  end

  it "has a version number" do
    expect(TinkoffClient::VERSION).not_to be nil
  end

  it "should TinkoffClient.configure work and configuration not to be nil" do
    TinkoffClient.configure do |c|
    c.payment_terminal_key = ENV['TERMINAL_KEY']
    c.payment_terminal_secret = ENV['TERMINAL_SECRET']
  end

    expect(TinkoffClient.configuration.payment_terminal_key).not_to be nil
    expect(TinkoffClient.configuration.payment_terminal_secret).not_to be nil
  end

end
