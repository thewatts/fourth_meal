require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase

  test "it is created with valid attributes" do
    assert order_items(:one).valid?
  end

  test "it_validates_order_id" do
    order_item = order_items(:one)
    order_item.update(:order_id => nil)
    refute order_item.valid?
  end

  test "it_validates_item_id" do
    order_item = order_items(:one)
    order_item.update(:item_id => nil)
    refute order_item.valid?
  end

  test "it_validates_quantity" do
    order_item = order_items(:one)
    order_item.update(:quantity => nil)
    refute order_item.valid?
  end

end
