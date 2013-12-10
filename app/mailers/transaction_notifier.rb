class TransactionMailer < ActionMailer::Base
  default from: "customer_service@platable.com"

  # def welcome_email(user)
  #   @user = user
  #   @url = "noshify.herokuapp.com/login"
  #   mail(to: @user.email, subject: "Welcome to Noshify")
  # end

  def user_email(user, transaction)
    @user = user
    @transaction = transaction
    @order = @transaction.order
    @address = @transaction.address
    @total = order_total(@order.order_items)
    @url = "noshify.herokuapp.com"
    mail(to: @transaction.email, subject: "Order Confirmation for #{@transaction.restaurant.name} on Noshify!")
  end

end