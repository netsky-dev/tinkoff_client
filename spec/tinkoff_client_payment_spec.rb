# frozen_string_literal: true
require "pry"
RSpec.describe TinkoffClient::Payment do
  before do
    TinkoffClient.configure do |c|
      c.payment_public_key = File.read(ENV["PUBLIC_KEY"])
      c.payment_terminal_key = ENV["TERMINAL_KEY"]
      c.payment_terminal_secret = ENV["TERMINAL_SECRET"]
    end

    @init = TinkoffClient::Payment.init(Amount: "1000", OrderId: rand(1000...2000))
  end

  it "should TinkoffClient::Payment.init return response" do
    result = TinkoffClient::Payment.init(Amount: "1000", OrderId: rand(1000...2000))
    expect(result).not_to be nil
    expect(result["Success"]).to eq(true)
  end

  it "should TinkoffClient::Payment.confirm return response" do
    result = TinkoffClient::Payment.confirm(PaymentId: @init["PaymentId"])
    expect(result).not_to be nil
    expect(result).to include("Success")
  end

  it "should TinkoffClient::Payment.get_state return status of payment" do
    result = TinkoffClient::Payment.get_state(PaymentId: @init["PaymentId"])
    expect(result).not_to be nil
    expect(result["Success"]).to eq(true)
    expect(result["Status"]).to eq("NEW")
  end

  it "should TinkoffClient::Payment.cancel return canceled payment" do
    result = TinkoffClient::Payment.cancel(PaymentId: @init["PaymentId"])
    expect(result).not_to be nil
    expect(result["Success"]).to eq(true)
    expect(result["Status"]).to eq("CANCELED")
  end

  it "should TinkoffClient::Payment.check_order return order status" do
    result = TinkoffClient::Payment.check_order(OrderId: @init["OrderId"])
    expect(result).not_to be nil
    expect(result["Success"]).to eq(true)
    expect(result["Payments"]).not_to be nil
  end

  it "should TinkoffClient::Payment.send_closing_receipt send closed check to checkout" do
    init_params = { Amount: "333", OrderId: rand(1000...2000),
                   Receipt: { Email: "test@test.ru", Taxation: "osn",
                             Items: [{ Name: "test", Quantity: "2",
                                       Amount: "333", Price: "333",
                                       Tax: "vat20", PaymentMethod: "full_payment",
                                       PaymentObject: "lottery_prize" }] } }

    init = TinkoffClient::Payment.init(init_params)
    expect(init).not_to be nil
    expect(init["Success"]).to eq(true)

    receipt_params = { PaymentId: "1986709080",
                      Receipt: { Email: "test@test.ru", Taxation: "osn",
                                Items: [{ Name: "test", Quantity: "2",
                                          Amount: "333", Price: "333",
                                          Tax: "vat20", PaymentMethod: "full_payment",
                                          PaymentObject: "lottery_prize" }] } }
    result = TinkoffClient::Payment.send_closing_receipt(receipt_params)
    expect(result).not_to be nil
    expect(result).to include("Success")
  end

  it "should TinkoffClient::Payment.finish_authorize return order Success status" do
    params = { PaymentId: @init["PaymentId"],
              Card: {
																						PAN: 5545454545454545,
																						ExpDate: 4545,
																						CardHolder: "IVAN PETROV",
																						CVV: "111",
																				} }
    result = TinkoffClient::Payment.finish_authorize(params)
    expect(result).not_to be nil
    expect(result).to include("Success")
  end
end
