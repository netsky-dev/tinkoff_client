# frozen_string_literal: true

require_relative "./request"
require_relative "./encrypt_card_data"

module TinkoffClient
  module Payment
    extend EncryptCardData

    # Метод создает платеж: продавец получает ссылку на платежную форму и должен перенаправить по ней покупателя
    # @param [Integer] Amount
    # @param [String] OrderId
    #   *  Полный список параметров https://www.tinkoff.ru/kassa/develop/api/payments/init-request/
    # @return [Hash]
    #   *
    #       {"Success"=>true,
    #       "ErrorCode"=>"0",
    #       "TerminalKey"=>"1111111111",
    #       "Status"=>"NEW",
    #       "PaymentId"=>"123456789",
    #       "OrderId"=>"3331",
    #       "Amount"=>1000,
    #       "PaymentURL"=>"https://securepayments.tinkoff.ru/q2wER3t0"}
    # @example
    #  #Предположим, что у нас есть User, Product и Order
    #
    #  #User
    #  {"id"=>1,
    #  "email"=>"a@test.ru",
    #  "phone"=>"+79031234567"}
    #
    #  #Product
    #  {"id"=>22,
    #  "name"=>"Наименование товара",
    #  "price"=>1000,
    #  "quantity"=>10}
    #
    #  #Order
    #  {"id"=>5,
    #  "user_id"=>1,
    #  "product_id"=>22,
    #  "paid"=>false}
    #
    #  #Реализация логики получения платежной ссылки
    #  def create
    #    order = order.find(params[:order_id]) #Объявляем наш order
    #    product = order.product #Объявляем продукт
    #    result = TinkoffClient::Payment.init(Amount: product.amount, OrderId: order.id) #Вызываем наш init метод
    #    if result["Success"] #в случае, если Success (boolean) вернет true
    #      redirect_to result["PaymentURL"] #Отправляем пользователя по ссылке на форму оплаты
    #    end
    #  end
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
