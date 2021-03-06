class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include AuthHelper
  include ApplicationHelper
  include OrdersHelper
  include UsersHelper
  include RestaurantsHelper
  
  helper_method :current_user, :current_order, :current_order_total, 
                :items_in_cart?, :order_total, :check_active, :unauthorized

end
