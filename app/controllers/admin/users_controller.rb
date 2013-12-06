class Admin::UsersController < ApplicationController
  before_action :define_current_restaurant

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save && current_order.id
      session[:user_id] = @user.id
      current_order.save
      redirect_to :back, :notice => "Signed up!"
    elsif @user.save && !current_order.id
      session[:user_id] = @user.id
      redirect_to restaurant_root_path(session[:current_restaurant] || root_path)
    else
      render "sessions/new"
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

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :display_name, :password, :password_confirmation, :admin)
  end

  def define_current_restaurant
    @restaurant = current_restaurant
  end
end
