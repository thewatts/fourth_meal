class SuperNotifier < ActionMailer::Base
  default from: "customer_service@noshify.com"

  def super_email(user, superman, link)
    @user = user
    @email = superman.email
    @link = link
    @restaurant = Restaurant.find(@user.orders.last.restaurant_id)
    mail(to: @email, subject: "New Restaurant #{@restaurant.name} on Noshify Pending Approval!")
  end

end
