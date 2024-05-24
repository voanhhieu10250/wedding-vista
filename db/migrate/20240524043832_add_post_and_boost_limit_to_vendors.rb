class AddPostAndBoostLimitToVendors < ActiveRecord::Migration[7.1]
  def change
    add_column :vendors, :post_limit, :integer, default: 0
    add_column :vendors, :boost_limit, :integer, default: 0
  end
end
