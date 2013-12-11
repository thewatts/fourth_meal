class Admin::ItemsController < ApplicationController
  # before_action :can_access
  layout 'admin'

  def index
    @items = current_restaurant.items
  end

  def destroy
    @item = Item.find(params[:id])
    @item.retire

    flash.notice = "#{@item.title} was removed from the menu!"

    redirect_to admin_items_path(session[:current_restaurant])
  end

  def new
    @item = Item.new
  end

  private

  def admin_item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :image_url)
  end
end
