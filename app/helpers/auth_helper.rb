module AuthHelper
  def super_access
    return unauthorized unless current_user.superman?
    true
  end

  def owner_access
    return unauthorized unless current_restaurant.is_owner?(current_user)
    true
  end

  def employee_access
    return unauthorized unless current_restaurant.is_employee?(current_user)
    true
  end

  def unauthorized
    redirect_to root_url, :notice => "You're not authorized to do that!"
  end
end