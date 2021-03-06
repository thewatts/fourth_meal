class Admin::DashboardController < ApplicationController
  before_action :ensure_user
  before_action :owner_access
  layout 'admin'

  def index
    @restaurant = current_restaurant
  end

  def update
    @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    @restaurant.update(restaurant_params)
  end

  def total_sales
    completed_orders = current_restaurant.orders.where(:status => 'complete')
    completed_orders.collect do |order|
      order.total_price
    end.reduce(:+)
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :slug)
  end

end
