class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # delegate :allow?, to: :current_permission

  # helper_method :allow?
  helper_method :current_user
  helper_method :current_order
  helper_method :current_order_total
  helper_method :items_in_cart?
  helper_method :order_total

  def current_order
    session[:orders] ||= {}
    @current_order ||= find_or_create_order
  end

  def order_total(order_items)
    order_items.inject(0) {|sum, i| sum += (i.item.price * i.quantity) }
  end

  def find_or_create_order
    if current_restaurant 
      if session[:orders].keys.include?(current_restaurant.id)
        order = Order.find(session[:orders][current_restaurant.id])
      end
    end

    if order
      @current_order = order
    else
      create_order
    end

  end

  def create_order
    @current_order = Order.create(status: 'unpaid', 
                                  restaurant: current_restaurant)
    session[:orders][current_restaurant.id] = @current_order.id
    @current_order
  end

  def clear_current_order
    @current_order = nil
    session[:orders].delete(current_restaurant.id)
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

  def current_order_total
    order_total(current_order.order_items).to_i
  end

  def items_in_cart?
    current_order.order_items.count > 0
  end

  # def categories
  #  @categories ||= Category.all
  # end
  

  # private
  
  # def current_permission
  #   @current_permission ||= Permission.new(current_user)
  # end

end
