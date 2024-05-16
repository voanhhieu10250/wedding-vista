class AddPublicToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :published, :boolean
  end
end
