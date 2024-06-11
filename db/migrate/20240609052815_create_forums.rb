class CreateForums < ActiveRecord::Migration[7.1]
  def change
    create_table :forums do |t|
      t.string :title
      t.text :description
      t.integer :users_count
      t.integer :discussions_count

      t.timestamps
    end
  end
end
