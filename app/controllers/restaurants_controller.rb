class RestaurantsController < ApplicationController
  layout 'home'
  def index
    @restaurants = Restaurant.where(:active => true).sort
  end

  def new
    verify_logged_in_user
    @restaurant = Restaurant.new
  end

  def create
    verify_logged_in_user
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save

      @restaurant.restaurant_users.create(:restaurant => @restaurant, 
                                          :user => current_user, 
                                          :role => "owner")

      flash.notice = "Your request has been submitted. 
                      You will be emailed when your restaurant is approved."
                      
      notify_super_of_request
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def notify_super_of_request
    superman = User.where(:super => true).first
    SuperNotifier.super_email(current_user, superman, link).deliver
    # TransactionNotifier.super_email(owner.email, current_user, link).deliver
  end

  def verify_logged_in_user
    unless current_user
      redirect_to log_in_path
      flash.notice = "Please login before attempting to create a new restaurant."
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end

end
