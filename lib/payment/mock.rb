module GateWay
  module Payment
    module Mock
      def mock_response(status = 'success')
        {
          txn_status: status,
          amount: options[:amount],
          merchant_transaction_ref: 'txn001',
          transaction_date: '2014-11-14',
          payment_gateway_merchant_reference: 'merc001',
          payment_gateway_transaction_reference: 'pg_txn0001'
        }
      end
    end
  end
end