class ItemsController < ApplicationController
  layout "application"

  def index
    @restaurant = Restaurant.find_by_slug(params[:restaurant])
    session[:current_restaurant] = @restaurant.to_param
    @items = @restaurant.items.active
    @page_title = "Full Menu"
  end

  def show
    @item = @restaurant.items.find(params[:item])
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :photo, :photo_file_name)
  end
end


