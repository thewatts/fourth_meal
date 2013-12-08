require './test/test_helper'

class TransactionTest < ActiveSupport::TestCase

  test "it is invalid without attributes" do
    transaction = Transaction.create()
    refute transaction.valid? 
  end

  test "it is valid with correct attributes" do
    assert transactions(:one).valid?
  end

  test "it validates order id" do
    transactions(:one).update(order_id: nil)
    refute transactions(:one).valid?
  end
  
end
