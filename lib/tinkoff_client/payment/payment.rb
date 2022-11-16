# frozen_string_literal: true

require_relative "./request"
require_relative "./card_data"

module TinkoffClient
  module Payment
    extend CardData

    def self.init(keys)
      Request.request(path: "Init", keys: keys)
    end

    def self.confirm(keys)
      Request.request(path: "Confirm", keys: keys)
    end

    def self.get_state(keys)
      Request.request(path: "GetState", keys: keys)
    end

    def self.cancel(keys)
      Request.request(path: "Cancel", keys: keys)
    end

    def self.check_order(keys)
      Request.request(path: "CheckOrder", keys: keys)
    end

    def self.send_closing_receipt(keys)
      Request.request(path: "SendClosingReceipt", keys: keys)
    end

    def self.finish_authorize(keys)
      card_data = encrypt_data(keys)
      keys[:CardData] = card_data
      Request.request(path: "FinishAuthorize", keys: keys.except(:Card))
    end
  end
end
