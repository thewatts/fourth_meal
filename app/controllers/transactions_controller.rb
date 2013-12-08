class TransactionsController < ApplicationController
  
  def new
    @transaction = Transaction.new
    if current_user
      render :new
    else
      redirect_to new_session_path
    end
  end

  def checkout_as_guest
    @transaction = Transaction.new
    render :new
  end

  def create
    @transaction = Transaction.create(order_id: current_order.id, address_id: current_address.id, stripe_token: params[:stripe_token])
    if @transaction.save
      @transaction.pay!
      current_order.update(:user_id => current_user.id, :status => "paid")
      session[:current_order] = nil
      flash[:notice] = "Successfully created your order!"
      redirect_to transaction_path(session[:current_restaurant], @transaction)
    else
      flash[:notice] = "There was a problem creating your order!"
      render :new
    end
  end

  def show
    @transaction = Transaction.find_by(id: params[:id])
    if current_user.id = @transaction.order.user_id
      render :show
    else
      @transaction = nil
      redirect_to restaurant_root_path(session[:current_restaurant])
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:stripe_token)
  end

end
