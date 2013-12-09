class AdminController < ApplicationController
  # before_action :can_access
  layout 'admin'

  def index
    @orders = current_restaurant.orders.all 
    @users = current_restaurant.users.all
    @items = current_restaurant.items.all
    @order_items = current_restaurant.order_items.all
    @total_sales = total_sales
    render :index
  end

  def total_sales
    completed_orders = current_restaurant.orders.where(:status => 'complete')
    completed_orders.collect do |order|
      order.total_price
    end.reduce(:+)
  end

end
