class LocationsController < ApplicationController
  before_action :check_active
  def index
    @page_title = "Locations"
  end
end
