class TransactionsController < ApplicationController
  
  def new
    @transaction = Transaction.new
    session[:current_address] = params[:address_id]
    set_forwarding_path
    if current_user && session[:current_address]
      find_current_user_address
      render :new
    else
      find_redirect
    end
  end

  def checkout_as_guest
    @transaction = Transaction.new
    current_or_new_guest_address
    render :new
  end

  def create
    create_transaction
    if @transaction.save
      process_saved_transaction
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

  def set_forwarding_path
    session[:forwarding_path] = addresses_path(session[:current_restaurant])
  end

  def find_current_user_address
    @address = current_user.addresses.find_by_id(session[:current_address])
  end

  def find_redirect
    if current_user
      redirect_to addresses_path(session[:current_restaurant])
    else
      redirect_to new_session_path
    end
  end

  def current_or_new_guest_address
    if session[:current_address]
      @address = Address.find(session[:current_address])
    else
      @address = Address.new
    end
  end

  def send_transaction_emails
    TransactionNotifier.user_email(@address.email, @transaction).deliver
    TransactionNotifier.user_email(@owner.email, @transaction).deliver
  end

  def create_transaction
    @transaction = Transaction.create(order_id: current_order.id, 
                                      address_id: session[:current_address],
                                      stripe_token: params["stripeToken"])
  end

  def process_saved_transaction
    @transaction.pay!
    clear_current_order
    @owner = current_restaurant.find_owner
    @address = Address.find(@transaction.address_id)
    send_transaction_emails
  end

  def transaction_params
    params.require(:transaction).permit(:stripe_token, :address, :stripe_email)
  end

end
