class TransactionNotifier < ActionMailer::Base
  default from: "customer_service@noshify.com"

  def user_email(email, transaction_id, link)
    @email = email
    @transaction = Transaction.find(transaction_id)
    @address = Address.find(@transaction.address_id)
    @total = @transaction.order.total_price
    @link = link
    @restaurant = Restaurant.find(@transaction.order.restaurant_id)
    mail(to: @email, subject: "Order Confirmation for #{@restaurant.name} on Noshify!")
  end

end
