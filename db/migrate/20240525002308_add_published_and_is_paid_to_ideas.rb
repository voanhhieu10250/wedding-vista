class AddPublishedAndIsPaidToIdeas < ActiveRecord::Migration[7.1]
  def change
    add_column :ideas, :published, :boolean, default: false
    add_column :ideas, :is_paid, :boolean, default: false
  end
end
