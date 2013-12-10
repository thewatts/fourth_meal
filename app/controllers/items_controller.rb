class ItemsController < ApplicationController
  layout "application"

  def load_category
    @categories = current_restaurant.categories
  end

  def in_category
    @restaurant = Restaurant.find_by_slug(params[:restaurant])
    load_category
    @category = @categories.find_by_slug(params[:category_slug])
    @items = @category.items.active
    @page_title = @category.title
    render :index
  end

  def index
    @restaurant = Restaurant.find_by_slug(params[:restaurant])
    session[:current_restaurant] = @restaurant.to_param
    load_category
    @items = @restaurant.items.active
    @page_title = "Full Menu"
  end

  def update
    @item = current_restaurant.items.find(params[:id])
    @item.update(item_params)
    flash.notice = "#{@item.name} was updated"
    redirect_to edit_item_path(@item.id)
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :photo, :photo_file_name)
  end

end


