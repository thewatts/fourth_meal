class AddRestaurantIdToItem < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.integer :restaurant_id
    end
  end
end
