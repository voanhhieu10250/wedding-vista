class ChangeServicesNameUniqueness < ActiveRecord::Migration[7.1]
  def change
    change_table :services do |t|
      t.remove_index :name
    end
  end
end
