class Admin::RestaurantsController < ApplicationController
  before_action :owner_access
  layout 'admin'

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    session[:current_restaurant] = @restaurant.to_param
    redirect_to admin_path(session[:current_restaurant]), :notice => "#{@restaurant.name} was updated!"
  end

  def show
    @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    redirect_to admin_path(session[:current_restaurant])
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :slug)
  end

end
