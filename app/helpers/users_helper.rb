module UsersHelper
  def current_user
    @current_user ||= find_user
  end

  def find_user
    User.find(session[:user_id]) if session[:user_id]
  end
end