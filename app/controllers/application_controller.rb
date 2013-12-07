class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # delegate :allow?, to: :current_permission

  # helper_method :allow?
  helper_method :current_user
  helper_method :current_order
  helper_method :current_order_total
  helper_method :items_in_cart?

  def current_order
    @current_order ||= find_or_create_order
  end

  def find_or_create_order
    order = Order.find_by(id: session[:order_id])
    if order
      @current_order = order
    else
      create_order
    end
  end

  def current_restaurant_order
    @current_restaurant_order ||= current_restaurant.orders.find_by_id(current_order.id) #|| current_restaurant.orders.find_by_user_id(session[:user_id])
  end

  def create_order
    @current_order = Order.create(status: 'unpaid', 
                                  restaurant: current_restaurant)
    session[:order_id] = @current_order.id
    @current_order
  end

  def current_user
    @current_user ||= find_user
  end

  def find_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def current_restaurant
    Restaurant.find_by_slug(session[:current_restaurant])
  end

  def current_order_total
    order_total(current_order.order_items).to_i
  end

  def items_in_cart?
    current_order && current_order.order_items.count > 0
  end

  # def categories
  #  @categories ||= Category.all
  # end
  

  # private
  
  # def current_permission
  #   @current_permission ||= Permission.new(current_user)
  # end

end
