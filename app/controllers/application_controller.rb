class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  delegate :allow?, to: :current_permission

  helper_method :allow?, :current_user, :current_restaurant, :current_cart,
                :items_in_cart?

  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_restaurant
    if params[:current_restaurant]
      @current_restaurant ||= Restaurant.find_by_slug(params[:current_restaurant])
    else
      @current_restaurant = Restaurant.find_by_slug(params[:restaurant])
    end
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


  def current_cart
    begin
      @current_cart ||= Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @current_cart = Cart.new
      # session[:cart_id] = @current_cart.id
      @current_cart
    end
    # end
    # if current_restaurant
    #   @current_cart ||= Cart.new(current_restaurant.to_param)
    # else
    #   @current_cart ||= Cart.new("none")
    # end
  end

  private
  
  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

end
