class ChangeAddressesColumns < ActiveRecord::Migration
  def change
    remove_column :addresses, :type
    add_column :addresses, :kind, :string, :null => false
  end
end
