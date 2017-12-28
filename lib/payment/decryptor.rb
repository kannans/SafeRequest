module GateWay
  module Payment
    class Decryptor
      include Base64

      def initialize(payload_string)
        @payload_options = {}
        @payload_string = payload_string
        @cipher = OpenSSL::Cipher::AES.new(128, :CBC)
      end

      attr_accessor :payload_options, :payload_string, :cipher

      def response_payload
        decrypt
      end

      private

      def decrypt
        cipher.decrypt
        cipher.key = chiper_key[0..15]
        @_decrypt ||= cipher.update(decode_text) + cipher.final
      end

      def decode_text
        urlsafe_decode64(payload_string)
      end

      def chiper_key
        GateWay::Payment::Base::SECRET_KEY_BASE
      end
    end
  end
end