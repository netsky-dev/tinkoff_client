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
    #    result = TinkoffClient::Payment.cancel(PaymentId: order.payment_id) #Вызываем наш cancel
    #  end
    # 
    # @see https://www.tinkoff.ru/kassa/develop/api/payments/getstate-description/
    # @see init
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
