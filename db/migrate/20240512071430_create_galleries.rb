class CreateGalleries < ActiveRecord::Migration[7.1]
  def change
    create_table :galleries do |t|
      t.references :service, null: false, foreign_key: true
      t.string :content_type
      t.string :name

      t.timestamps
    end
  end
end
