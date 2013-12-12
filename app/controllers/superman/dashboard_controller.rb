class Superman::DashboardController < ApplicationController
  layout 'superman'
  # before_action :super_access

  def index
    @restaurants = Restaurant.all.sort
  end
  
end
