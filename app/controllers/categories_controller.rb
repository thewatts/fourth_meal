class CategoriesController < ApplicationController
  def index
    @restaurant ||= current_restaurant
    @categories = current_restaurant.categories
  end

  def show
    @restaurant ||= current_restaurant
    @category = Category.find(params[:id])
  end
end
