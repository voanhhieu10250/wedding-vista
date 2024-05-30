class RemoveBoostLimitFromVendors < ActiveRecord::Migration[7.1]
  def up
    remove_column :vendors, :boost_limit
  end

  def down
    add_column :vendors, :boost_limit, :integer, default: 0
  end
end
