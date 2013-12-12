class Superman::RestaurantsController < ApplicationController
  def destroy
    @restaurant = Restaurant.find_by_slug(params[:id])
    @restaurant.toggle_status
    toggle_status_message
    redirect_to superman_path
  end

  private

  def toggle_status_message
    @restaurant.active ? activate_message : deactivate_message
  end

  def deactivate_message
    flash.notice = "#{@restaurant.name} was taken offline!"
  end

  def activate_message
    flash.notice = "#{@restaurant.name} was reactivated!"
  end

end
