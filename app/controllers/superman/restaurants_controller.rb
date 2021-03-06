class Superman::RestaurantsController < ApplicationController
  layout 'superman'
  before_action :ensure_user
  before_action :super_access

  def index
    @restaurants = Restaurant.where(:status => "pending")
  end

  def rejected
    @restaurants = Restaurant.where(:status => "rejected")
  end

  def destroy
    @restaurant = Restaurant.find_by_slug(params[:id])
    @restaurant.toggle_status
    toggle_status_message
    redirect_to superman_path
  end

  def approve
    @restaurant = Restaurant.find_by_slug(params[:format])
    @restaurant.approve
    redirect_to superman_path, :notice => "#{@restaurant.name} was approved!"
  end

  def reject
    @restaurant = Restaurant.find_by_slug(params[:format])
    @restaurant.reject
    redirect_to superman_path, :notice => "#{@restaurant.name} was rejected!"
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
