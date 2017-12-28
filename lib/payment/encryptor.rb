module GateWay
  module Payment
    class Encryptor
      include Base64
      def initialize(options)
        @payload_options = options
        @payload_string = ""
        @cipher = OpenSSL::Cipher::AES.new(128, :CBC)
        @verbose = true
      end

      attr_accessor :payload_options, :payload_string, :cipher, :verbose

      def payload_to_pg
        logger if verbose
        urlsafe_encode64(cipher_text)
      end

      private

      def payload_string
        @_payload_string ||=
          payload_options.map { |k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join("|")
      end

      def payload_with_sha
        hash = Digest::SHA1.hexdigest(payload_string)
        @_payload_with_sha ||= payload_string + "|hash=" + hash
      end

      def cipher_text
        cipher.encrypt
        cipher.key = chiper_key[0..15]
        @_cipher_text ||= cipher.update(payload_with_sha) + cipher.final
      end

      def chiper_key
        GateWay::Payment::Base::SECRET_KEY_BASE
      end

      def logger
        Logger.info("Convert String: #{payload_string}")
        Logger.info("Payload with SHA: #{payload_with_sha}")
        Logger.info("Base64(AES 128(payload_with_sha)): #{urlsafe_encode64(cipher_text)}")
        Logger.info("*" * 50)
      end
    end
  end
end