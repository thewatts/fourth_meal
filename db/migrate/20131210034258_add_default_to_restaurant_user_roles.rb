class AddDefaultToRestaurantUserRoles < ActiveRecord::Migration
  def change
    change_column :restaurant_users, :role, :string, :default => "customer"
  end
end
