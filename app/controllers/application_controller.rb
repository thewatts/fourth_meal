class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  delegate :allow?, to: :current_permission

  helper_method :allow?, :current_user, :current_restaurant, :current_cart,
                :items_in_cart?

  def current_cart
    if current_restaurant
      @current_cart = Cart.new(current_restaurant.to_param)
    else
      @current_cart = Cart.new("none")
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_restaurant
    @current_restaurant ||= Restaurant.find_by_slug(params[:current_restaurant])
  end

  def items_in_cart?
    !current_cart.empty?
  end

  def logout
    session[:user_id] = nil
    @current_cart = nil
    @current_user = nil
    @current_restaurant = nil
    @current_permission = nil
  end

  private
  
  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

end
