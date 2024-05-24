class RenameTypeToKindOnSpendings < ActiveRecord::Migration[7.1]
  def up
    rename_column :spendings, :type, :kind
  end

  def down
    rename_column :spendings, :kind, :type
  end
end
