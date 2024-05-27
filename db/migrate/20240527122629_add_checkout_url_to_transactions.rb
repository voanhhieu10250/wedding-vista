class AddCheckoutUrlToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :checkout_url, :string
  end
end
