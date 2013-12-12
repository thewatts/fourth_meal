class Superman::DashboardController < ApplicationController
  layout 'superman'
  before_action :ensure_user
  before_action :super_access

  def index
    @restaurants = Restaurant.all.reject {|r| r.rejected?}.sort
  end
  
end
