# frozen_string_literal: true

require_relative "./request"
require_relative "./encrypt_card_data"

module TinkoffClient
  module Payment
    extend EncryptCardData

    # Метод создает платеж: продавец получает ссылку на платежную форму и должен перенаправить по ней покупателя
    #
    # Полный список параметров https://www.tinkoff.ru/kassa/develop/api/payments/init-request/
    #
    # @param [Number] Amount
    # @param [String] OrderId
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
    #  "paid"=>false,
    #  "payment_id"=>nil}
    #
    #  #Простая реализация логики получения платежной ссылки
    #  def create
    #    order = order.find(params[:order_id]) #Объявляем наш order
    #    product = order.product #Объявляем продукт
    #    result = TinkoffClient::Payment.init(Amount: product.amount, OrderId: order.id) #Вызываем наш init метод
    #    if result["Success"] #в случае, если Success (boolean) вернет true
    #      order.update(:order_params)
    #      redirect_to result["PaymentURL"] #Отправляем пользователя по ссылке на форму оплаты
    #    end
    #  end
    # 
    #  private
    #  def order_params
    #   params.transform_keys(&:underscore).permit(:payment_id)#Трансформируем ответ из Snake в Camel и пермитим его
    #  end
    # @see https://www.tinkoff.ru/kassa/develop/api/payments/init-request/
    def self.init(keys)      
      Request.request(path: "Init", keys: keys)
    end

    # Метод подтверждает платеж передачей реквизитов, а также списывает средства с карты покупателя при одностадийной оплате и блокирует указанную сумму при двухстадийной.
    # Используется, если у площадки есть сертификация PCI DSS и собственная платежная форма.
    #
    # Полный список параметров https://www.tinkoff.ru/kassa/develop/api/payments/confirm-request/
    #
    # @param [Number] PaymentId
    # @return [Hash]
    #   *
    #       {"Success"=>true,
    #       "ErrorCode"=>"0",
    #       "TerminalKey"=>"1111111111",
    #       "Status"=>"CONFIRMED",
    #       "PaymentId"=>"123456789",
    #       "OrderId"=>"3331"}
    # @example
    #
    #  #Order
    #  {"id"=>5,
    #  "user_id"=>1,
    #  "product_id"=>22,
    #  "paid"=>false,
    #  "payment_id"=>"123456789"} #Payment id получен в методе init
    #
    #  def create
    #    order = order.find(params[:order_id]) #Объявляем наш order
    #    result = TinkoffClient::Payment.confirm(PaymentId: order.payment_id) #Вызываем наш confirm
    #  end
    # 
    # @see https://www.tinkoff.ru/kassa/develop/api/payments/confirm-description/
    # @see init
    def self.confirm(keys)
      Request.request(path: "Confirm", keys: keys)
    end


    # Метод возвращает текущий статус платежа.
    #
    # Полный список параметров https://www.tinkoff.ru/kassa/develop/api/payments/getstate-description/
    #
    # @param [Number] PaymentId
    # @return [Hash]
    #   *
    #  {
    #   "Success"=>true,
    #   "ErrorCode"=>"0",
    #   "Message"=>"OK",
    #   "TerminalKey"=>"TinkoffBankTest",
    #   "Status"=>"CONFIRMED",
    #   "PaymentId"=>"2304882",
    #   "OrderId"=>"#419",
    #   "Amount"=>1000
    #   }
    # @example
    #
    #  #Order
    #  {"id"=>5,
    #  "user_id"=>1,
    #  "product_id"=>22,
    #  "paid"=>false,
    #  "payment_id"=>"123456789"} #Payment id получен в методе init
    #
    #  def create
    #    order = order.find(params[:order_id]) #Объявляем наш order
    #    result = TinkoffClient::Payment.get_state(PaymentId: order.payment_id) #Вызываем наш get_state
    #  end
    # 
    # @see https://www.tinkoff.ru/kassa/develop/api/payments/getstate-description/
    # @see init
    def self.get_state(keys)
      Request.request(path: "GetState", keys: keys)
    end

    # Метод отменяет платеж.
    #
    # Полный список параметров https://www.tinkoff.ru/kassa/develop/api/payments/cancel-description/
    #
    # @param [Number] PaymentId
    # @return [Hash]
    #   *
    #  {
    #   "Success"=>true,
    #   "ErrorCode"=>"0",
    #   "Message"=>"OK",
    #   "TerminalKey"=>"TinkoffBankTest",
    #   "Status"=>"REFUNDED",
    #   "PaymentId"=>"2304882",
    #   "OrderId"=>"#419",
    #   "Amount"=>1000
    #   }
    # @example
    #
    #  #Order
    #  {"id"=>5,
    #  "user_id"=>1,
    #  "product_id"=>22,
    #  "paid"=>false,
    #  "payment_id"=>"123456789"} #Payment id получен в методе init
    #
    #  def create
    #    order = order.find(params[:order_id]) #Объявляем наш order
    #    result = TinkoffClient::Payment.cancel(PaymentId: order.payment_id) #Вызываем наш cancel
    #  end
    # 
    # @see https://www.tinkoff.ru/kassa/develop/api/payments/cancel-description/
    # @see init
    def self.cancel(keys)
      Request.request(path: "Cancel", keys: keys)
    end

    # Метод возвращает статус заказа.
    #
    # Полный список параметров https://www.tinkoff.ru/kassa/develop/api/payments/checkorder-description/
    #
    # @param [Number] OrderId
    # @return [Hash]
    #   *
    #  {
    #   "Success": true,
    #   "ErrorCode": "0",
    #   "Message": "OK",
    #   "OrderId": "21057",
    #   "TerminalKey": "TinkoffBankTest",
    #   "Payments": [
    #    {
    #        "Status": "REJECTED",
    #        "PaymentId": 10063,
    #        "Rrn": 1234567,
    #        "Amount": 555,
    #        "Success": false,
    #        "ErrorCode": "1051",
    #        "Message": "Недостаточно средств на карте"
    #    },
    #    {
    #        "Status": "AUTH_FAIL",
    #        "PaymentId": 1005563,
    #        "Rrn": 1234567,
    #        "Amount": 555,
    #        "Success": false,
    #        "ErrorCode": "76",
    #        "Message": "Операция по иностранной карте недоступна."
    #    },
    #    {
    #        "Status": "NEW",
    #        "PaymentId": 100553363,
    #        "Rrn": 1234567,
    #        "Amount": 555,
    #        "Success": true,
    #        "ErrorCode": "0",
    #        "Message": "ok"
    #    }
    #   ]
    #  }
    # @example
    #
    #  #Order
    #  {"id"=>5,
    #  "user_id"=>1,
    #  "product_id"=>22,
    #  "paid"=>false,
    #  "payment_id"=>"123456789"}
    #
    #  def create
    #    order = order.find(params[:order_id]) #Объявляем наш order
    #    result = TinkoffClient::Payment.check_order(OrderId: order.id) #Вызываем наш check_order
    #  end
    # 
    # @see https://www.tinkoff.ru/kassa/develop/api/payments/checkorder-description/
    # @see init
    def self.check_order(keys)
      Request.request(path: "CheckOrder", keys: keys)
    end

    # Метод позволяет отправить закрывающий чек в кассу.
    # Условия работы метода:
    # Закрывающий чек может быть отправлен если платежная сессия по первому чеку находится в статусе CONFIRMED.
    # В платежной сессии был передан объект Receipt.
    # В объекте Receipt был передан хотя бы один объект Receipt.Items.PaymentMethod = "full_prepayment" или "prepayment" или "advance"
    #
    # Полный список параметров https://www.tinkoff.ru/kassa/develop/api/payments/SendClosingReceipt-description/
    #
    # @param [Number] PaymentId
    # @param [Hash] Receipt
    # @param [Hash] Items
    # @return [Hash]
    #   *
    #  {
    #   "Success"=>true,
    #   "ErrorCode"=>"0",
    #   "Message"=>"null",
    #   }
    # @example
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
    #  "paid"=>false,
    #  "payment_id"=>"123456789"} #Payment id получен в методе init
    #
    #  def create
    #    order = order.find(params[:order_id]) #Объявляем наш order
    #    params = { 
    #      PaymentId: order.payment_id,
    #      Receipt: { Email: order.user.email, Taxation: "osn",
    #      Items: [{ Name: order.product.title, Quantity: "1",
    #      Amount: order.product.price, Price: order.product.price,
    #      Tax: "vat20", PaymentMethod: "full_payment",
    #      PaymentObject: "lottery_prize" }] } 
    #    }
    #    result = TinkoffClient::Payment.send_closing_receipt(params) #Вызываем наш send_closing_receipt
    #  end
    # 
    # @see https://www.tinkoff.ru/kassa/develop/api/payments/SendClosingReceipt-description/
    # @see init
    def self.send_closing_receipt(keys)
      Request.request(path: "SendClosingReceipt", keys: keys)
    end

    # Метод подтверждает платеж передачей реквизитов, а также списывает средства с карты покупателя при одностадийной оплате и блокирует указанную сумму при двухстадийной.
    #
    # Используется, если у площадки есть сертификация PCI DSS и собственная платежная форма.
    #
    # Полный список параметров https://www.tinkoff.ru/kassa/develop/api/payments/finish-authorize/
    #
    # @param [Number] PaymentId
    # @param [Hash] Card
    # @param [Number] PAN (Card)
    # @param [Number] ExpDate (Card)
    # @param [String] CardHolder (Card)
    # @param [CVV] CardHolder (Card)
    # @return [Hash]
    #   *
    #  {
    #   "Success"=>true,
    #   "ErrorCode"=>"0",
    #   "Message"=>"null",
    #   }
    # @example
    #
    #  #Order
    #  {"id"=>5,
    #  "user_id"=>1,
    #  "product_id"=>22,
    #  "paid"=>false,
    #  "payment_id"=>"123456789"} #Payment id получен в методе init
    #
    #  def create
    #    order = order.find(params[:order_id]) #Объявляем наш order
    #    params = { 
    #      PaymentId: order.payment_id,
    #      Card: { PAN: 5545454545454545, ExpDate: 4545, CardHolder: "IVAN PETROV", CVV: "111"}
    #    }
    #    result = TinkoffClient::Payment.finish_authorize(params) #Вызываем наш finish_authorize
    #  end
    # 
    # @see https://www.tinkoff.ru/kassa/develop/api/payments/finish-authorize/
    # @see encrypt_data
    def self.finish_authorize(keys)
      card_data = encrypt_data(keys)
      keys[:CardData] = card_data
      Request.request(path: "FinishAuthorize", keys: keys.except(:Card))
    end
  end
end
