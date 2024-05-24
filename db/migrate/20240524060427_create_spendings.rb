class CreateSpendings < ActiveRecord::Migration[7.1]
  def change
    create_table :spendings do |t|
      t.references :vendor, null: false, foreign_key: true
      t.decimal :amount
      t.string :type

      t.timestamps
    end
  end
end
