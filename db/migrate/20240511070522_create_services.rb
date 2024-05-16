class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.decimal :pricing

      t.timestamps
    end

    add_index :services, :name, unique: true

    add_reference :services, :vendor, null: false, foreign_key: true, index: true
  end
end
