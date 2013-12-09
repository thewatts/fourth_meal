class AddressesController < ApplicationController

  def index
    @addresses = current_user.addresses
  end

  def create
    @address = Address.create(address_params)
    if @address.save
      session[:current_address] = @address.id
      flash.notice = "Your address was successfully added."
    else
      flash.notice = "Errors prevented the address from being saved: #{@address.errors.full_messages}"
    end
    redirect_to :back
  end

  def change
    session[:current_address] = nil
    redirect_to :back
  end

  private
  def address_params
    params.require(:address).permit(:first_name, :last_name, :street_address, :city, :state, :zipcode, :email)
  end

end
