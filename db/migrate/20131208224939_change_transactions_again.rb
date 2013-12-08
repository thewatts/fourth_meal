class ChangeTransactionsAgain < ActiveRecord::Migration
  def change
    remove_column :transactions, :restaurant_id
    remove_column :transactions, :user_id
    remove_column :transactions, :credit_card_number
    remove_column :transactions, :credit_card_expiration
  end
end
