class ItemsController < ApplicationController
  layout "application"

  def index
    @restaurant = Restaurant.find_by_slug(params[:restaurant])
    session[:current_restaurant] = @restaurant.to_param
    @items = @restaurant.items.active
    @page_title = "Full Menu"
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    flash.notice = "#{@item.name} was updated"
    redirect_to edit_item_path(@item.id)
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :photo, :photo_file_name)
  end

end


