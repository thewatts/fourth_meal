module OrdersHelper

  def order_total(order_items)
    order_items.inject(0) {|sum, i| sum += (i.item.price * i.quantity) }
  end

  def items_in_cart?
    current_order && current_order.order_items.count > 0
  end

end
