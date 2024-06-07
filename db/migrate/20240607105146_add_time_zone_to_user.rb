class AddTimeZoneToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :time_zone, :string, default: "UTC"
  end
end
