class RestaurantsController < ApplicationController
  layout 'home'
  def index
    @restaurants = Restaurant.where(:active => true).sort
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      @restaurant.restaurant_users.create(:restaurant => @restaurant, 
                                          :user => current_user, 
                                          :role => "owner")
      flash.notice = "Your request has been submitted. 
                      You will be emailed when your restaurant is approved."
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end

end
