class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include OrdersHelper
  include UsersHelper
  include RestaurantsHelper
  
  helper_method :current_user, :current_order, :current_order_total, 
                :items_in_cart?, :order_total

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, session)
  end

end
