class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
