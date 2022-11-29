# frozen_string_literal: true
 
require 'pry'
RSpec.describe TinkoffClient::Payment do
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


  it "calls the init method with the correct arguments" do
    keys = {Amount: "1000", OrderId: "1000"}
    allow(TinkoffClient::Payment::Request).to receive(:request).with(path: "Init", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payment::Request).to receive(:request).with(path: "Init", keys: keys)
    expect(TinkoffClient::Payment.init(keys)).to eq({data: "test"})
  end

  it "calls the confirm method with the correct arguments" do
    keys = {PaymentId: "1"}
    allow(TinkoffClient::Payment::Request).to receive(:request).with(path: "Confirm", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payment::Request).to receive(:request).with(path: "Confirm", keys: keys)
    expect(TinkoffClient::Payment.confirm(keys)).to eq({data: "test"})
  end

  it "calls the get_state method with the correct arguments" do
    keys = {PaymentId: "1"}
    allow(TinkoffClient::Payment::Request).to receive(:request).with(path: "GetState", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payment::Request).to receive(:request).with(path: "GetState", keys: keys)
    expect(TinkoffClient::Payment.get_state(keys)).to eq({data: "test"})
  end

  it "calls the cancel method with the correct arguments" do
    keys = {PaymentId: "1"}
    allow(TinkoffClient::Payment::Request).to receive(:request).with(path: "Cancel", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payment::Request).to receive(:request).with(path: "Cancel", keys: keys)
    expect(TinkoffClient::Payment.cancel(keys)).to eq({data: "test"})
  end

  it "calls the check_order method with the correct arguments" do
    keys = {OrderId: "1"}
    allow(TinkoffClient::Payment::Request).to receive(:request).with(path: "CheckOrder", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payment::Request).to receive(:request).with(path: "CheckOrder", keys: keys)
    expect(TinkoffClient::Payment.check_order(keys)).to eq({data: "test"})
  end

  it "calls the send_closing_receipt method with the correct arguments" do
    keys = { PaymentId: "1986709080",
                      Receipt: { Email: "test@test.ru", Taxation: "osn",
                                Items: [{ Name: "test", Quantity: "2",
                                          Amount: "333", Price: "333",
                                          Tax: "vat20", PaymentMethod: "full_payment",
                                          PaymentObject: "lottery_prize" }] } }
    allow(TinkoffClient::Payment::Request).to receive(:request).with(path: "SendClosingReceipt", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payment::Request).to receive(:request).with(path: "SendClosingReceipt", keys: keys)
    expect(TinkoffClient::Payment.send_closing_receipt(keys)).to eq({data: "test"})
  end


  it "calls the finish_authorize method with the correct arguments" do
    keys = { PaymentId: "1",
              Card: {
                      PAN: 5545454545454545,
                      ExpDate: 4545,
                      CardHolder: "IVAN PETROV",
                      CVV: "111",
                    } }
    allow(TinkoffClient::Payment::Request).to receive(:request).with(path: "FinishAuthorize", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payment::Request).to receive(:request).with(path: "FinishAuthorize", keys: keys)
    expect(TinkoffClient::Payment.finish_authorize(keys)).to eq({data: "test"})
  end

end
