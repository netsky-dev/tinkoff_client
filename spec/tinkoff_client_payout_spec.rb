# frozen_string_literal: true
require "rest-client"

RSpec.describe TinkoffClient::Payout do

 
  it "calls the add_customer method with the correct arguments" do
    keys = {CustomerKey: "1000"}
    
    allow(TinkoffClient::Payout::Request).to receive(:request).with(path: "AddCustomer", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payout::Request).to receive(:request).with(path: "AddCustomer", keys: keys)
    expect(TinkoffClient::Payout.add_customer(keys)).to eq({data: "test"})
  end

  it "calls the get_customer method with the correct arguments" do
    keys = {CustomerKey: "1000"}
    allow(TinkoffClient::Payout::Request).to receive(:request).with(path: "GetCustomer", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payout::Request).to receive(:request).with(path: "GetCustomer", keys: keys)
    expect(TinkoffClient::Payout.get_customer(keys)).to eq({data: "test"})
  end

  it "calls the add_card method with the correct arguments" do
    keys = {CustomerKey: "1000"}
    allow(TinkoffClient::Payout::Request).to receive(:request).with(path: "AddCard", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payout::Request).to receive(:request).with(path: "AddCard", keys: keys)
    expect(TinkoffClient::Payout.add_card(keys)).to eq({data: "test"})
  end

  it "calls the get_card_list method with the correct arguments" do
    keys = {CustomerKey: "1000"}
    allow(TinkoffClient::Payout::Request).to receive(:request).with(path: "GetCardList", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payout::Request).to receive(:request).with(path: "GetCardList", keys: keys)
    expect(TinkoffClient::Payout.get_card_list(keys)).to eq({data: "test"})
  end

  it "calls the init method with the correct arguments" do
    keys = {CustomerKey: "1000", OrderId: "supertest1", Amount: "333", CardId: "1"}
    allow(TinkoffClient::Payout::Request).to receive(:request).with(path: "Init", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payout::Request).to receive(:request).with(path: "Init", keys: keys)
    expect(TinkoffClient::Payout.init(keys)).to eq({data: "test"})
  end

  it "calls the get_state method with the correct arguments" do
    keys = {PaymentId: "1000"}
    allow(TinkoffClient::Payout::Request).to receive(:request).with(path: "GetState", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payout::Request).to receive(:request).with(path: "GetState", keys: keys)
    expect(TinkoffClient::Payout.get_state(keys)).to eq({data: "test"})
  end

  it "calls the payment method with the correct arguments" do
    keys = {PaymentId: "1000"}
    allow(TinkoffClient::Payout::Request).to receive(:request).with(path: "Payment", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payout::Request).to receive(:request).with(path: "Payment", keys: keys)
    expect(TinkoffClient::Payout.payment(keys)).to eq({data: "test"})
  end

  it "calls the remove_card method with the correct arguments" do
    keys = {CustomerKey: "1000", CardId: "1"}
    allow(TinkoffClient::Payout::Request).to receive(:request).with(path: "RemoveCard", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payout::Request).to receive(:request).with(path: "RemoveCard", keys: keys)
    expect(TinkoffClient::Payout.remove_card(keys)).to eq({data: "test"})
  end

  it "calls the remove_customer method with the correct arguments" do
    keys = {CustomerKey: "1000"}
    allow(TinkoffClient::Payout::Request).to receive(:request).with(path: "RemoveCustomer", keys: keys).and_return({data: "test"})
    expect(TinkoffClient::Payout::Request).to receive(:request).with(path: "RemoveCustomer", keys: keys)
    expect(TinkoffClient::Payout.remove_customer(keys)).to eq({data: "test"})
  end

end
