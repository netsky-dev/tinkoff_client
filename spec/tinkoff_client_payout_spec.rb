# frozen_string_literal: true
require "pry"
require "rest-client"
require_relative "./e2e/e2e"

RSpec.describe TinkoffClient::Payout do
  before(:all) do
    TinkoffClient.configure do |c|
      c.payout_terminal_key = ENV["PAYOUT_TERMINAL_KEY"]
      c.payout_terminal_secret = ENV["PAYOUT_TERMINAL_SECRET"]
      c.payout_certificate = "./open-api-cert.pem"
      c.payout_private_key = "./private.key"
    end

    @customer = TinkoffClient::Payout.add_customer(CustomerKey: "1000")

    @e2e = E2E.new
  end

  after(:all) do
    TinkoffClient::Payout.remove_customer(CustomerKey: "1000")
  end

  it "should TinkoffClient::Payout.add_customer return customer" do
    expect(@customer).not_to be nil
    expect(@customer["Success"]).to eq(true)
  end

  it "should TinkoffClient::Payout.get_customer return customer" do
    result = TinkoffClient::Payout.get_customer(CustomerKey: "1000")
    expect(result).not_to be nil
    expect(result["Success"]).to eq(true)
    expect(result["CustomerKey"]).to eq("1000")
  end

  it "should TinkoffClient::Payout.add_card return link for card adding" do
    result = TinkoffClient::Payout.add_card(CustomerKey: "1000")
    @e2e.add_card(path: result["PaymentURL"])
    expect(result).not_to be nil
    expect(result["Success"]).to eq(true)
    expect(result["PaymentURL"]).not_to be nil
  end

  let(:cards) { TinkoffClient::Payout.get_card_list(CustomerKey: "1000") }
  it "should TinkoffClient::Payout.get_card_list return cards array" do
    expect(cards).not_to be nil
    expect(cards).to be_instance_of(Array)
    expect(cards).not_to be_empty
  end

  let(:payment) { TinkoffClient::Payout.init(CustomerKey: "1000", OrderId: "supertest1", Amount: "333", CardId: cards[0]["CardId"]) }
  it "should TinkoffClient::Payout.init return payment with status checked" do
    expect(payment).not_to be nil
    expect(payment["Success"]).to eq(true)
    expect(payment["Status"]).to eq("CHECKED")
  end

  it "should TinkoffClient::Payout.get_state return payment with status" do
    result = TinkoffClient::Payout.get_state(PaymentId: payment["PaymentId"])
    expect(result).not_to be nil
    expect(result["Success"]).to eq(true)
    expect(result["Status"]).to eq("CHECKED")
  end

  it "should TinkoffClient::Payout.payment return response with status COMPLETED" do
    result = TinkoffClient::Payout.payment(PaymentId: payment["PaymentId"])
    expect(result).not_to be nil
    expect(result["Success"]).to eq(true)
    expect(result["PaymentId"]).to eq(payment["PaymentId"])
    expect(result["Status"]).to eq("COMPLETED")
  end

  it "should TinkoffClient::Payout.remove_card return card with D status" do
    result = TinkoffClient::Payout.remove_card(CustomerKey: "1000", CardId: cards[0]["CardId"])
    expect(result).not_to be nil
    expect(result["CardId"]).to eq(cards[0]["CardId"])
    expect(result["Status"]).to eq("D")
  end

  it "should TinkoffClient::Payout.remove_customer return response" do
    result = TinkoffClient::Payout.remove_customer(CustomerKey: "1000")
    expect(result).not_to be nil
    expect(result["Success"]).to eq(true)
  end
end
