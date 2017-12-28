# post requests and get reponse
module GateWay
  module Payment
    class PostData
      include GateWay::Payment::Mock

      def initialize(options = {})
        @options = options
        @payload_data = ''
        @values = {}
        @success = nil
        @fail = nil
        @verbose = true
      end

      attr_accessor :options, :payload_data, :success, :fail, :values, :parse_string, :verbose

      def connect!
        post_it_to_server
      end

      def parse_string
        @values.split("|").map {|x| x.split("=")}.to_h
      end

      private

      def encrypted_request_payload
        logger("...Request Encrypted ....")
        GateWay::Payment::Encryptor.new(options).payload_to_pg
      end

      def encrypted_response_payload
        logger("...Get Encrypted Success Reponse ...")
        GateWay::Payment::Encryptor.new(mock_response).payload_to_pg
      end

      def encrypted_failur_response_payload
        logger("...Get Encrypted Fail Reponse ...")
        GateWay::Payment::Encryptor.new(mock_response('fail')).payload_to_pg
      end

      def decrypt(string)
        logger("...Decrypt the reponse payload ...")
        GateWay::Payment::Decryptor.new(string).response_payload
      end

      def post_it_to_server
        response = { msg: encrypted_request_payload }
        # post it with url here

        # mocked response success
        @payload_data = encrypted_response_payload
        @success = true
        @fail = nil #rescue error here...

        get_response_parameters
        parse_string
      end

      def get_response_parameters
        decrypted_data = decrypt(payload_data)
        logger(decrypted_data)
        @values = decrypted_data
      end

      def logger(message)
        Logger.info(message) if verbose
      end
    end
  end
end