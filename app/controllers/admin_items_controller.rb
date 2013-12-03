class AdminItemsController < ApplicationController
  include AdminItemsHelper
  # before_action :can_access

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

  private
  def admin_item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :image_url)
  end

end
