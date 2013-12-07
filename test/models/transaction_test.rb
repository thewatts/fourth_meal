require './test/test_helper'

class TransactionTest < ActiveSupport::TestCase

  test "it is invalid without attributes" do
    transaction = Transaction.create()
    refute transaction.valid? 
  end

  test "it is valid with correct attributes" do
    assert transactions(:one).valid?
  end

  test "it does not create a transaction when first name is empty" do
    transaction = transactions(:one)
    transaction.update(first_name: nil)
    refute transaction.valid?
  end

  test "it does not create a transaction when last name is empty" do
    transaction = transactions(:one)
    transaction.update(last_name: nil)
    refute transaction.valid?
  end

  test "it does not create a transaction when zipcode is invalid" do
    transaction = transactions(:one)
    transaction.update(zipcode: nil)
    refute transaction.valid?
  end
end
