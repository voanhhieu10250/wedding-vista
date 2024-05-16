class AddCateroryToServices < ActiveRecord::Migration[7.1]
  def change
    add_reference :services, :category, null: true, foreign_key: true
  end
end
