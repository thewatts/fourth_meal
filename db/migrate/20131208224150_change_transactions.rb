class ChangeTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :first_name
    remove_column :transactions, :last_name
    remove_column :transactions, :zipcode

    add_column :transactions, :address_id, :integer
    add_column :transactions, :restaurant_id, :integer, :null => false
    add_column :transactions, :user_id, :integer
    add_column :transactions, :stripe_token, :string
  end
end
