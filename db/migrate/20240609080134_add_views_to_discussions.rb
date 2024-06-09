class AddViewsToDiscussions < ActiveRecord::Migration[7.1]
  def change
    add_column :discussions, :views, :integer, default: 0
  end
end
