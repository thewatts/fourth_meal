class RestaurantsController < ApplicationController
  layout 'home'
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

end
