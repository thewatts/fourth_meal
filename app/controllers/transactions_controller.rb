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

  def add_guest_address
    @address = Address.create(address_params)
    if @address.save 
      session[:current_address] = @address.id
      redirect_to guest_transaction_path(session[:current_restaurant])
    else
      flash.notice = "Your address failed to save"
      redirect_to :back
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
    @transaction = Transaction.new(order_id: current_order.id, 
                                   address_id: session[:current_address],
                                   stripe_token: params["stripeToken"])
    if @transaction.save
      @transaction.pay!
      clear_current_order
      @owner = current_restaurant.restaurant_users.where(role: "owner").last.user 
      @address = Address.find(@transaction.address_id)
      TransactionNotifier.user_email(@address.email, @transaction).deliver
      TransactionNotifier.user_email(@owner.email, @transaction).deliver
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
    @total = order_total(@transaction.order.order_items)
  end

  private

  def transaction_params
    params.require(:transaction).permit(:stripe_token, :address, :stripe_email)
  end

  def address_params
    params.require(:address).permit(:first_name, :last_name, :street_address, :city, :state, :zipcode, :email)
  end

end
