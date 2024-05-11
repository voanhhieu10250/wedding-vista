class AddSlugToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :slug, :string
    add_index :services, :slug, unique: true
  end
end
