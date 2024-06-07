class AddTimeZoneToVendor < ActiveRecord::Migration[7.1]
  def change
    add_column :vendors, :time_zone, :string, default: "UTC"
  end
end
