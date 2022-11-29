# frozen_string_literal: true

RSpec.describe TinkoffClient do
  before do
    TinkoffClient.configure do |c|
      c.payment_public_key = "./public.pem"
      c.payment_terminal_key = "1111111111"
      c.payment_terminal_secret = "1111111111"

      c.payout_terminal_key = "1111111111"
      c.payout_terminal_secret = "1111111111"
      c.payout_certificate = "./open-api-cert.pem"
      c.payout_private_key = "./private.key"
    end
  end

  it "has a version number" do
    expect(TinkoffClient::VERSION).not_to be nil
  end

  it "should TinkoffClient.configure work and configuration not to be nil" do
    expect(TinkoffClient.configuration.payment_public_key).not_to be nil
    expect(TinkoffClient.configuration.payment_terminal_key).not_to be nil
    expect(TinkoffClient.configuration.payment_terminal_secret).not_to be nil
    expect(TinkoffClient.configuration.payout_terminal_key).not_to be nil
    expect(TinkoffClient.configuration.payout_terminal_secret).not_to be nil
    expect(TinkoffClient.configuration.payout_certificate).not_to be nil
    expect(TinkoffClient.configuration.payout_private_key).not_to be nil

  end
end
