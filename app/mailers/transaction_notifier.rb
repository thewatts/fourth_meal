class TransactionNotifier < ActionMailer::Base
  default from: "customer_service@noshify.com"

  # def welcome_email(user)
  #   @user = user
  #   @url = "noshify.herokuapp.com/login"
  #   mail(to: @user.email, subject: "Welcome to Noshify")
  # end

  def user_email(user, transaction)
    @user = user
    @transaction = transaction
    @address = Address.find(@transaction.address_id)
    @total = order_total(@transaction.order.order_items)
    @url = "noshify.herokuapp.com"
    @restaurant = Restaurant.find(@transaction.order.restaurant_id)
    mail(to: @user.email, subject: "Order Confirmation for #{@restaurant.name} on Noshify!")
  end

  def order_total(order_items)
    order_items.inject(0) {|sum, i| sum += (i.item.price * i.quantity) }
  end

end