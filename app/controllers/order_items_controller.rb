class OrderItemsController < ApplicationController
  def create
    @order_item = OrderItem.new(:item_id => params[:item], :order_id => current_order.id, :quantity => 1)
    if @order_item.save
      flash.notice = "Item was saved to your cart."
    else
      flash.notice = "There was a problem saving your item."
    end
    @restaurant = Restaurant.find_by_slug(session[:current_restaurant])
    redirect_to restaurant_root_path(@restaurant)
  end

  def destroy
    OrderItem.find(params[:oiid]).destroy
    if current_order.order_items.count > 0
      flash[:notice] = "The item was removed from your cart."
    else
      flash[:notice] = "Your order has been cancelled."
    end
    redirect_to order_path(session[:current_restaurant], session[:current_order])
  end
  
end