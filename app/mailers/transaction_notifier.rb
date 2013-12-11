class TransactionNotifier < ActionMailer::Base
  default from: "customer_service@noshify.com"

  # def welcome_email(user)
  #   @user = user
  #   @url = "noshify.herokuapp.com/login"
  #   mail(to: @user.email, subject: "Welcome to Noshify")
  # end

  def user_email(email, transaction)
    @email = email
    @transaction = transaction
    @address = Address.find(@transaction.address_id)
    @total = order_total(@transaction.order.order_items)
    @url = "noshify.herokuapp.com"
    # @url_link = link_to root_url + request.path.to_s[1..-1]
    @restaurant = Restaurant.find(@transaction.order.restaurant_id)
    mail(to: @email, subject: "Order Confirmation for #{@restaurant.name} on Noshify!")
  end

  def order_total(order_items)
    order_items.inject(0) {|sum, i| sum += (i.item.price * i.quantity) }
  end

end
