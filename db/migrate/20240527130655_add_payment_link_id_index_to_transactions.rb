class AddPaymentLinkIdIndexToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_index :transactions, :payment_link_id
  end
end
