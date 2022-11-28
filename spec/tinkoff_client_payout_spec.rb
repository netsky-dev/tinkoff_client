# frozen_string_literal: true
require "rest-client"

RSpec.describe TinkoffClient::Payout do

  let(:mock) { double(TinkoffClient::Payout) }

  it "calls the add_customer method with the correct arguments" do
    params = {CustomerKey: "1000"}
    expect(mock).to receive(:add_customer).with(params)
    mock.add_customer(params)
  end

  it "calls the get_customer method with the correct arguments" do
    params = {CustomerKey: "1000"}
    expect(mock).to receive(:get_customer).with(params)
    mock.get_customer(params)
  end

  it "calls the add_card method with the correct arguments" do
    params = {CustomerKey: "1000"}
    expect(mock).to receive(:add_card).with(params)
    mock.add_card(params)
  end

  it "calls the get_card_list method with the correct arguments" do
    params = {CustomerKey: "1000"}
    expect(mock).to receive(:get_card_list).with(params)
    mock.get_card_list(params)
  end

  it "calls the init method with the correct arguments" do
    params = {CustomerKey: "1000", OrderId: "supertest1", Amount: "333", CardId: "1"}
    expect(mock).to receive(:init).with(params)
    mock.init(params)
  end

  it "calls the get_state method with the correct arguments" do
    params = {PaymentId: "1000"}
    expect(mock).to receive(:get_state).with(params)
    mock.get_state(params)
  end

  it "calls the payment method with the correct arguments" do
    params = {PaymentId: "1000"}
    expect(mock).to receive(:payment).with(params)
    mock.payment(params)
  end

  it "calls the remove_card method with the correct arguments" do
    params = {CustomerKey: "1000", CardId: "1"}
    expect(mock).to receive(:remove_card).with(params)
    mock.remove_card(params)
  end

  it "calls the remove_customer method with the correct arguments" do
    params = {CustomerKey: "1000"}
    expect(mock).to receive(:remove_customer).with(params)
    mock.remove_customer(params)
  end

end
