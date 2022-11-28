# frozen_string_literal: true

require 'pry'
RSpec.describe TinkoffClient::Payment do

  let(:mock) { double(TinkoffClient::Payment) }

  it "calls the init method with the correct arguments" do
    params = {Amount: "1000", OrderId: "1000"}
    expect(mock).to receive(:init).with(params)
    mock.init(params)
  end

  it "calls the confirm method with the correct arguments" do
    params = {PaymentId: "1"}
    expect(mock).to receive(:confirm).with(params)
    mock.confirm(params)
  end

  it "calls the get_state method with the correct arguments" do
    params = {PaymentId: "1"}
    expect(mock).to receive(:get_state).with(params)
    mock.get_state(params)
  end

  it "calls the cancel method with the correct arguments" do
    params = {PaymentId: "1"}
    expect(mock).to receive(:cancel).with(params)
    mock.cancel(params)
  end

  it "calls the check_order method with the correct arguments" do
    params = {OrderId: "1"}
    expect(mock).to receive(:check_order).with(params)
    mock.check_order(params)
  end

  it "calls the send_closing_receipt method with the correct arguments" do
    params = { PaymentId: "1986709080",
                      Receipt: { Email: "test@test.ru", Taxation: "osn",
                                Items: [{ Name: "test", Quantity: "2",
                                          Amount: "333", Price: "333",
                                          Tax: "vat20", PaymentMethod: "full_payment",
                                          PaymentObject: "lottery_prize" }] } }
    expect(mock).to receive(:send_closing_receipt).with(params)
    mock.send_closing_receipt(params)
  end


  it "calls the finish_authorize method with the correct arguments" do
    params = { PaymentId: "1",
              Card: {
                      PAN: 5545454545454545,
                      ExpDate: 4545,
                      CardHolder: "IVAN PETROV",
                      CVV: "111",
                    } }
    expect(mock).to receive(:finish_authorize).with(params)
    mock.finish_authorize(params)
  end

end
