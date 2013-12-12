class Admin::RestaurantsController < ApplicationController
  before_action :owner_access
  layout 'admin'

  def update
    @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    @restaurant.update(restaurant_params)
    redirect_to admin_path(session[:current_restaurant])
  end

  def show
    @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    redirect_to admin_path(session[:current_restaurant])
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end

end
