class Transaction < ActiveRecord::Base
  belongs_to :order
  validates_presence_of :order_id

  def pay!
    order.status = "paid" 
    order.save
  end
end