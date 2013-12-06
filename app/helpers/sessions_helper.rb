module SessionsHelper

  def redirect_to_current_restaurant_or_root
    if session[:current_restaurant]
      redirect_to restaurant_root_path(session[:current_restaurant]) 
    else
      redirect_to root_path
    end
  end

end
