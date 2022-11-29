# frozen_string_literal: true

require "openssl"
require "base64"

module TinkoffClient
  module Payment
    module EncryptCardData

      # Метод реализует шифрование данных карты
      #
      # Используется в методе FinishAuthorize https://www.tinkoff.ru/kassa/develop/api/payments/finishAuthorize-request/
      #
      # Объект CardData собирается в виде списка «ключ=значение» (разделитель «;»), зашифровывается открытым ключом (X509 RSA 2048), получившееся бинарное значение кодируется в Base64. Открытый ключ генерируется Банком и выдается при регистрации терминала. 
      #
      # Все поля обязательны.
      # @param [Number] PAN
      # @param [Number] ExpDate
      # @param [String] CardHolder
      # @param [String] CVV
      # @see finish_authorize
      def encrypt_data(keys)
        card = keys[:Card]
        concatenated = card.map { |k, v| [k, v].join("=") }.join(";")
        public_key = OpenSSL::PKey::RSA.new File.read(TinkoffClient.configuration.payment_public_key)
        card_data = Base64.encode64(public_key.public_encrypt(concatenated))
      end
    end
  end
end
