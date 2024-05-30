class CreatePriorityBoostings < ActiveRecord::Migration[7.1]
  def change
    create_table :priority_boostings do |t|
      t.references :service, null: false, foreign_key: true
      t.integer :level, default: 4, null: false
      t.datetime :start_time
      t.datetime :end_time
      t.string :status, null: false, default: "PENDING"

      t.timestamps
    end

    add_index :priority_boostings, :level
    add_index :priority_boostings, :status
    add_index :priority_boostings, :start_time
    add_index :priority_boostings, :end_time
  end
end
