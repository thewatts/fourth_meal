class Admin::ItemsController < ApplicationController
  # before_action :can_access
  layout 'admin'

  def index
    @items = current_restaurant.items.sort
  end

  def destroy
    @item = Item.find(params[:id])
    @item.toggle_status
    toggle_active_message
    find_toggle_message[@item.retired]
    redirect_to admin_items_path(session[:current_restaurant])
  end

  def new
    @item = Item.new
  end

  private

  def find_toggle_message
    {false => toggle_active_message, true => toggle_inactive_message}
  end

  def toggle_active_message
    flash.notice = "#{@item.title} was added to the menu!"
  end

  def toggle_inactive_message
    flash.notice = "#{@item.title} was removed from the menu!"
  end

  def admin_item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :image_url)
  end
end
