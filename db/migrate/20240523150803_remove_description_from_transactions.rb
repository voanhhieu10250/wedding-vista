class RemoveDescriptionFromTransactions < ActiveRecord::Migration[7.1]
  def up
    remove_column :transactions, :description
  end

  def down
    add_column :transactions, :description, :string
  end
end
