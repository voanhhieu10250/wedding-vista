class AddPaymentIdToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :payment_link_id, :string
  end
end
