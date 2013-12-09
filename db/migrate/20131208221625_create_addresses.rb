class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.text :street_address
      t.string :city
      t.string :state
      t.integer :zipcode
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end
end
