class RemoveKindFromAddresses < ActiveRecord::Migration
  def change
    remove_column :addresses, :kind
  end
end
