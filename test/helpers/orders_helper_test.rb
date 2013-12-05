require 'test_helper'

class OrdersHelperTest < ActionView::TestCase
  test "order total is calculated for one order item with one item" do
    OrderItem.create(:order_id => 50, :item_id => 3, :quantity => 1)
    order = Order.create(:id => 50)
    price = 5.99
    assert_equal price, order_total(order.order_items)
  end

  test "order total is calculated for many order items with many items" do
    OrderItem.create(:order_id => 50, :item_id => 2, :quantity => 2)
    OrderItem.create(:order_id => 50, :item_id => 3, :quantity => 5)
    order = Order.create(:id => 50)
    price = 37.93
    assert_equal price, order_total(order.order_items)
  end
end
