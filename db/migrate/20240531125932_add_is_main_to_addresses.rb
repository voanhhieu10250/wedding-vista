class AddIsMainToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :is_main, :boolean, default: false
  end
end
