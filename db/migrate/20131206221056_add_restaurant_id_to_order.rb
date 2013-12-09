class AddRestaurantIdToOrder < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.integer :restaurant_id
    end
  end
end
