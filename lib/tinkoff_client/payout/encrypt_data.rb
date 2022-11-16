# frozen_string_literal: true

require "openssl"
require "base64"

module TinkoffClient
  module Payout
    module EncryptData
      def encrypt_data(keys)
        pkey = OpenSSL::PKey::RSA.new File.read(TinkoffClient.configuration.payout_private_key)
        cert = OpenSSL::X509::Certificate.new File.read(TinkoffClient.configuration.payout_certificate)
        x509_serial_number = cert.serial.to_s

        context_keys = { :TerminalKey => TinkoffClient.configuration.payout_terminal_key, **keys }
        concatenated = context_keys.sort.transpose[1].join

        digest = OpenSSL::Digest::SHA256.new concatenated
        signed_bytes = pkey.sign "SHA256", digest.digest

        signature_value = Base64::strict_encode64 signed_bytes
        digest_value = Base64::strict_encode64 digest.digest

        result = { signature_value: signature_value, digest_value: digest_value, x509_serial_number: x509_serial_number }
      end
    end
  end
end
