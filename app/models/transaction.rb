class Transaction < ActiveRecord::Base
  belongs_to :order
  validates_presence_of :order_id

  def pay!
    order.status = "paid" 
    order.save
  end

  def self.send_transaction_emails(address, owner, transaction, link)
    MyMailer.perform(address, owner, transaction, link)
  end

  def total
    order.total_price
  end
end
