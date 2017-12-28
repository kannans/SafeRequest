$:.unshift File.expand_path('../lib', __FILE__)
require 'gateway'

gate = GateWay::Payment::Base.new({
  bank_ifsc_code: "12366788",
  bank_account_number: "234234342424243",
  amount: "1000",
  merchant_transaction_ref: "txn001",
  transaction_date: "2014-11-14",
  payment_gateway_merchant_reference: "merc001"
})

p gate.post
