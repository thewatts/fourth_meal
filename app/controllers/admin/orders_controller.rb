class Admin::OrdersController < ApplicationController
  # before_action :can_access
  layout 'admin'
  
  def index
    @orders = Order.all
    authorize! :manage, @orders
  end

  def show
    @order = Order.find(params[:id])
    authorize! :manage, @order
  end

  def destroy
    @order = Order.find(params[:id])
    authorize! :manage, @order
    @order.destroy

    flash.notice = "Order number #{@order.id} removed!"

    redirect_to admin_orders_path
  end
  
end
