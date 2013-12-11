module RestaurantsHelper
  def current_restaurant
    @current_restaurant = Restaurant.find_by_slug(session[:current_restaurant]) || Restaurant.find_by_slug(params[:restaurant])
    session[:current_restaurant] = @current_restaurant.to_param
    @current_restaurant
  end
end
