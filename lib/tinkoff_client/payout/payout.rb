# frozen_string_literal: true

require_relative "./request"

module TinkoffClient
  module Payout
    def self.add_customer(keys)
      Request.request(path: "AddCustomer", keys: keys)
    end

    def self.get_customer(keys)
      Request.request(path: "GetCustomer", keys: keys)
    end

    def self.remove_customer(keys)
      Request.request(path: "RemoveCustomer", keys: keys)
    end

    def self.add_card(keys)
      Request.request(path: "AddCard", keys: keys)
    end

    def self.get_card_list(keys)
      Request.request(path: "GetCardList", keys: keys)
    end

    def self.remove_card(keys)
      Request.request(path: "RemoveCard", keys: keys)
    end

    def self.init(keys)
      Request.request(path: "Init", keys: keys)
    end

    def self.payment(keys)
      Request.request(path: "Payment", keys: keys)
    end

    def self.get_state(keys)
      Request.request(path: "GetState", keys: keys)
    end
  end
end
