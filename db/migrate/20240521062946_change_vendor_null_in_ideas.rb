class ChangeVendorNullInIdeas < ActiveRecord::Migration[7.1]
  def change
    change_column_null :ideas, :vendor_id, true
  end
end
