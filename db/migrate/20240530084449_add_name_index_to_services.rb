class AddNameIndexToServices < ActiveRecord::Migration[7.1]
  def change
    add_index :services, :name
  end
end
