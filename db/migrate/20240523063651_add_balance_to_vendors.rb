class AddBalanceToVendors < ActiveRecord::Migration[7.1]
  def change
    add_column :vendors, :balance, :decimal
  end
end
