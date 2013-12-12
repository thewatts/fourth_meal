module RestaurantsHelper
  def current_restaurant
    @current_restaurant = Restaurant.find_by_slug(session[:current_restaurant]) || Restaurant.find_by_slug(params[:restaurant_slug])
    session[:current_restaurant] = @current_restaurant.to_param
    @current_restaurant
  end

  def check_active
    restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    unless restaurant && restaurant.active?
      redirect_to root_path, :notice => "Sorry, this restaurant is currently offline for maintenance."
    end
  end
end


