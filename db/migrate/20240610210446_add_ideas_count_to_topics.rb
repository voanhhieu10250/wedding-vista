class AddIdeasCountToTopics < ActiveRecord::Migration[7.1]
  def change
    add_column :topics, :ideas_count, :integer, default: 0
  end
end
