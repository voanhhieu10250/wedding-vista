class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.string :name
      t.text :description
      t.references :topic_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
