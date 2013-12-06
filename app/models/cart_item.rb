class CartItem
  attr_reader :item, :quantity

  def initialize(item, quantity)
    @item = item
    @quantity = quantity
  end

  def title
    item.title
  end

  def price
    item.price
  end

  def total
    BigDecimal.new(quantity.to_s*price.to_s)
  end

end
