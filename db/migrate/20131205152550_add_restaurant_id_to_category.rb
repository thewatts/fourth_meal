class AddRestaurantIdToCategory < ActiveRecord::Migration
  def change
    change_table :categories do |t|
      t.integer :restaurant_id
    end
  end
end
