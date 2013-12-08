class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user && session[:current_order]
      session[:user_id] = @user.id
      flash[:notice] = "Logged in!"
      if current_restaurant
        redirect_to restaurant_root_path(session[:current_restaurant])
      else 
        redirect_to root_path
      end
    elsif @user
      session[:user_id] = @user.id
      flash[:notice] = "Logged in!"
      if current_restaurant
        redirect_to restaurant_root_path(session[:current_restaurant])
      else 
        redirect_to root_path
      end
    else
      @user = User.new
      flash[:notice] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:current_order] = nil
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
