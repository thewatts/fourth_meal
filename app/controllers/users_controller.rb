class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if current_restaurant && @user.save
      session[:user_id] = @user.id
      current_order.update(user: @user) if current_order
      redirect_to session[:forwarding_path] || restaurant_root_path(session[:current_restaurant]), :notice => "Signed up!"
    elsif @user.save
      session[:user_id] = @user.id
      redirect_to root_path, :notice => "Signed up!"
    else
      render "sessions/new", notice: "FAIL"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), :notice => "Credentials updated!"
    else
      redirect_to user_path(@user.id), :notice => "Your account was not saved for some reason!"
    end
  end

  def show
    @user = current_user
  end

  def is_admin?
    current_user && current_user.admin
  end

private
    
  def set_user
    @user = user.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :full_name, :display_name, :password, :password_confirmation, :admin)
  end
end
