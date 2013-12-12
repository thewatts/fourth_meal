class Admin::RestaurantsController < ApplicationController
  before_action :owner_access
  layout 'admin'

  def update
    @restaurant = Restaurant.find_by_slug(params[:restaurant])
    @restaurant.update(restaurante_params)
    redirect_to admin_path(session[:current_restaurant])
  end

  def show
    @restaurant = Restaurant.find_by_slug(params[:restaurant])
    redirect_to admin_path(session[:current_restaurant])
  end

  private

  def restaurante_params
    params.require(:restaurante).permit(:name, :description)
  end

end
