module AdminHelper
  def owner_access
    unauthorized unless current_restaurant.is_owner?(current_user)
  end

  def employee_access
    unauthorized unless current_restaurant.is_employee?(current_user)
  end

  def unauthorized
    redirect_to root_url, :notice => "You're not authorized to do that!"
  end
end