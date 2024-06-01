class AddMainAddressToServices < ActiveRecord::Migration[7.1]
  def change
    add_reference :services, :main_address, foreign_key: { to_table: :addresses }, null: true
  end
end
