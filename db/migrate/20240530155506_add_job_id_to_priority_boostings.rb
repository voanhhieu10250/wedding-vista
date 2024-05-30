class AddJobIdToPriorityBoostings < ActiveRecord::Migration[7.1]
  def change
    add_column :priority_boostings, :job_id, :bigint
  end
end
