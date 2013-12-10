class AdminItemsController < ApplicationController
  # before_action :can_access
  layout 'admin'

  def index
    @items = Item.all
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    flash.notice = "#{@item.name} removed from Menu!"

    redirect_to admin_items_path
  end

  def new
    @item = Item.new
  end

  def update
    @item = current_restaurant.items.find(params[:id])
    @item.update(item_params)
    flash.notice = "#{@item.name} was updated"
    redirect_to edit_item_path(@item.id)
  end

  private
  def admin_item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :image_url)
  end

end
