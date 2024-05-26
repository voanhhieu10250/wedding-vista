class ChangeTopicNullInTopics < ActiveRecord::Migration[7.1]
  def change
    change_column_null :ideas, :topic_id, true
  end
end
