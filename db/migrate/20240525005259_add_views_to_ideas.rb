class AddViewsToIdeas < ActiveRecord::Migration[7.1]
  def change
    add_column :ideas, :views, :integer, default: 0
  end
end
