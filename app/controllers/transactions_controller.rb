class TransactionsController < ApplicationController
  
  def new
    @transaction = Transaction.new
    session[:current_address] = params[:address_id]
    session[:forwarding_path] = addresses_path(session[:current_restaurant])
    if current_user && session[:current_address]
      @address = current_user.addresses.find_by_id(session[:current_address])
      render :new
    elsif current_user
      redirect_to addresses_path(session[:current_restaurant])
    else
      redirect_to new_session_path
    end
  end

  def checkout_as_guest
    @transaction = Transaction.new
    if session[:current_address]
      @address = Address.find(session[:current_address])
    else
      @address = Address.new
    end
    render :new
  end

  def create
    # @address = Address.find(session[:current_address]) if session[:current_address]

    @transaction = Transaction.create(order_id: current_order.id, 
                                      address_id: session[:current_address],
                                      stripe_token: params[:stripe_token])
    if @transaction.save
      @transaction.pay!
      clear_current_order
      flash[:notice] = "Successfully submitted your order!"
      redirect_to transaction_path(session[:current_restaurant], @transaction)
    else
      flash[:notice] = "There was a problem creating your order!"
      render :new
    end
  end

  def show
    @transaction = Transaction.find_by(id: params[:id])
    @address = Address.find(@transaction.address_id)
  end

  private

  def transaction_params
    params.require(:transaction).permit(:stripe_token, :address, :stripe_email)
  end

end
