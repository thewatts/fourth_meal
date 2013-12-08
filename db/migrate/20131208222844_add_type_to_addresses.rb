class AddTypeToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :type, :string, :null => false
  end
end
