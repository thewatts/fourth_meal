class Cart < ActiveRecord::Base
  belongs_to :restaurant
  has_many :line_items, :dependent => :destroy

  def initialize
    @cart_items ||= []
  end

  def items
    @cart_items
  end

  def add(item)
    @cart_items << item
  end

  def remove(item)
    @cart_items.pop(item)
  end

  def delete
    @cart_items = []
  end

  def empty?
    @cart_items == []
  end

  def total
    @cart_items.collect{|i| i.total}.inject(&:+)
  end

end