class AddIconToForums < ActiveRecord::Migration[7.1]
  def change
    add_column :forums, :icon, :string
  end
end
