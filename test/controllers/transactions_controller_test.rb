require "test_helper"

class TransactionsControllerTest < ActionController::TestCase

  def test_sends_email_on_valid_create
    current_user = users(:one)
    post(:create, {"restaurant" => "kfc",
                   "transaction" => transactions(:one),
                   "stripe_token" => "askd2n0ck2m0c",
                   "stripe_email" => "hello@example.com",
                   "current_order" => orders(:one)},
                   :current_restaurant => "kfc", 
                   :current_address => addresses(:one).id,
                   :current_user => users(:one))
    assert_equal "Order Confirmed!", last_email.subject
    assert_email "shopper@example.com", last_email.to.first
    assert last_email.body.include?("Helqo!")
  end
end
