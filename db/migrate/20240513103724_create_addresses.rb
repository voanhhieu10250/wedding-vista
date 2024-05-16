class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :service, null: false, foreign_key: true
      t.string :full_address
      t.string :district
      t.string :province
      t.string :phone
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
    add_index :addresses, :district
    add_index :addresses, :province
  end
end
