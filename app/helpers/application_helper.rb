module ApplicationHelper
  
  def page_title
    if @page_title
      "- #{@page_title}"
    elsif content_for?(:title)
      "- " + content_for(:title)
    end
  end

  def order_total(order_items)
    order_items.inject(0) {|sum, i| sum += (i.item.price * i.quantity) }
  end

  def items_in_cart?
    current_order.order_items.count > 0
  end
  
end
