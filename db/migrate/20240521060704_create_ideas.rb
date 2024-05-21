class CreateIdeas < ActiveRecord::Migration[7.1]
  def change
    create_table :ideas do |t|
      t.string :title
      t.text :description
      t.references :vendor, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end

    add_index :ideas, :title
  end
end
