class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  
  helper_method :current_user
  helper_method :current_order
  helper_method :current_order_total
  helper_method :items_in_cart?
  helper_method :order_total


  def set_session_orders
    session[:orders] ||= {}
  end

  def add_order_to_session
    session[:orders][current_restaurant.id] = @current_order.id
  end

  def delete_order_from_session
    session[:orders].delete(current_restaurant.id)
  end



  def current_order
    set_session_orders
    @current_order ||= find_or_create_order
  end

  def find_or_create_order
    if find_order
      @current_order = find_order
    else
      create_order
    end
  end

  def find_order
    if current_restaurant && session[:orders].keys.include?(current_restaurant.id)
      order = Order.find(session[:orders][current_restaurant.id])
    end
  end

  def create_order
    @current_order = Order.create(status: 'unpaid', 
                                  restaurant: current_restaurant)
    add_order_to_session
    @current_order
  end

  def clear_current_order
    @current_order = nil
    delete_order_from_session
  end

  def current_order_total
    order_total(current_order.order_items).to_i
  end

  def items_in_cart?
    current_order.order_items.count > 0
  end



  def current_user
    @current_user ||= find_user
  end

  def find_user
    User.find(session[:user_id]) if session[:user_id]
  end

  

  def current_restaurant
    @current_restaurant = Restaurant.find_by_slug(session[:current_restaurant]) || Restaurant.find_by_slug(params[:restaurant])
    session[:current_restaurant] = @current_restaurant.to_param
    @current_restaurant
  end

end
