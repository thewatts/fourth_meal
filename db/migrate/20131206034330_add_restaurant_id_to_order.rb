class AddRestaurantIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :restaurant_id, :integer
    remove_column :orders, :store_id
  end
end
