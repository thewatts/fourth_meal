class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include OrdersHelper
  
  helper_method :current_user, :current_order, :current_order_total, 
                :items_in_cart?, :order_total


  




  



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
