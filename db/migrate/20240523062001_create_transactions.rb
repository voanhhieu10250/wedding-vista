class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :description
      t.decimal :amount
      t.string :status, default: "PENDING"

      t.timestamps
    end

    add_reference :transactions, :vendor, null: false, foreign_key: true, index: true
  end
end
