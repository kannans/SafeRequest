# get parameters
module GateWay
  module Payment
    class Base
      SECRET_KEY_BASE = 'Q9fbkBF8au24C9wshGRW9ut8ecYpyXye5vhFLtHFdGjRg3a4HxPYRfQaKutZx5N4'
      API_URL = 'http://example.com/payment'

      def initialize(options = {})
        @options = options
      end

      attr_accessor :options

      def post
        Logger.info("Initializing the post request...")

        response = GateWay::Payment::PostData.new(options)
        response.connect!
        if response.success
          response.values
          response.parse_string
        else
          raise "Payment gateway error"
        end
      end
    end
  end
end

