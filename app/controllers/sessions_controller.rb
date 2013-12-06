class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user && session[:current_order]
      session[:user_id] = @user.id
      current_order
      flash[:notice] = "Logged in!"
      redirect_to restaurant_root_path(session[:current_restaurant])
    elsif @user
      session[:user_id] = @user.id
      session[:current_order] = @user.orders.max_by()
      flash[:notice] = "Logged in!"
      redirect_to restaurant_root_path(session[:current_restaurant])
    else
      @user = User.new
      flash.now.alert = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:current_order] = nil
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
