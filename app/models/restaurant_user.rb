class RestaurantUser < ActiveRecord::Base
  validates_numericality_of :restaurant_id, :greater_than => 0
  validates_numericality_of :user_id, :greater_than => 0

  belongs_to :restaurant
  belongs_to :user

end
