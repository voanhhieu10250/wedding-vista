class AddCommentsCountToDiscussions < ActiveRecord::Migration[7.1]
  def change
    add_column :discussions, :comments_count, :integer, default: 0
  end
end
