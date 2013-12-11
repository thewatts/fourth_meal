class OrdersController < ApplicationController

  helper_method :add_item_to_order

  def new
    @order = Order.new
  end

  def show
    @page_title = "Your Order"
    @order = current_order
    @order_items = @order.order_items
    @items = current_restaurant.items.active
    if @order_items.count < 1
      redirect_to restaurant_root_path(session[:current_restaurant])
    end
  end

  def create
    @order = Order.create(:status => "unpaid", :user_id => 1)
    if params[:item]
      item = Item.find(params[:item])
      @order.order_items.build(item: item, quantity: 1) 
      @order.save
    end 
    redirect_to order_path(session[:current_restaurant], @order.id)
  end

  def update
    current_order.save
    @order = current_order
    session[:current_order] = @order.id
    @item = Item.find(params[:item])
    add_or_increment_item
    flash.notice = "Item was added to your cart!"
    redirect_to :back
  end

  def destroy
    @order = Order.find(params[:id])
    @order.items.destroy_all
    flash[:notice] = "Your order was successfully cancelled."
    redirect_to :back
  end

  private

  def add_or_increment_item
    if existing_order_item
      @order_item = existing_order_item
      @order_item.add_one
    else
      add_item
    end
  end

  def existing_order_item
    current_order.order_items.find_by_item_id(params[:item])
  end

  def add_item
    @order_item = OrderItem.create(
      :order_id => current_order.id, 
      :item_id => @item.id, 
      :quantity => 1)
  end

end
