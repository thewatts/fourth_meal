class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  delegate :allow?, to: :current_permission

  helper_method :allow?
  helper_method :current_user
  helper_method :current_order
  helper_method :current_order_total
  helper_method :items_in_cart?

  def current_order
    @current_order ||= Order.find_by_id(session[:current_order]) || Order.new(status: "unpaid", restaurant_id: current_restaurant.id)
    @current_order.update(:user_id => current_user.id) if current_user
    @current_order
  end

  def categories
   @categories ||= Category.all
  end

  def current_order_total
    order_total(current_order.order_items).to_i
  end

  def current_restaurant
    Restaurant.find_by_slug(session[:current_restaurant])
  end

  def items_in_cart?
    current_order && current_order.order_items.count > 0
  end
  
  private

   def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
   end
   
   def current_permission
     @current_permission ||= Permission.new(current_user)
   end

end
