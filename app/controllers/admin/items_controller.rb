class Admin::ItemsController < ApplicationController
  before_action :define_current_restaurant
  layout 'admin'

  def index
    @items = @restaurant.items
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item], :restaurant_id => @restaurant.id)
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    flash.notice = "#{@item.name} was updated"
    redirect_to edit_item_path(@item.id)
  end

  def retire
    @item = Item.find(params[:id])
    @item.update(:retired => true)

    flash.notice = "#{@item.name} was removed from Menu!"

    redirect_to admin_items_path
  end


  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :image_url)
  end

  def define_current_restaurant
    @restaurant = current_restaurant
  end

end
