require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase  

  test "order total is calculated for one order item with one item" do
    assert_equal 4, order_total(orders(:one).order_items)
  end

  test "order total is calculated for many order items with many items" do
    assert_equal 10, order_total(orders(:two).order_items)
  end

end
