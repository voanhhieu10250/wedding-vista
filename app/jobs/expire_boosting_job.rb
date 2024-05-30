class ExpireBoostingJob < ApplicationJob
  queue_as :default

  def perform(boosting_id)
    PriorityBoosting.find(boosting_id).expired!
  end
end
