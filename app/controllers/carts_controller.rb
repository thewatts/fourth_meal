class CartsController < ApplicationController
  def show
  end

  def update
    @item = Item.find(params[:item])
    current_cart.add(@item)
    flash.notice = "Item successfully added to cart."
    redirect_to :back
  end

  def remove
  end

  def destroy
  end

end