class ActivateBoostingJob < ApplicationJob
  queue_as :default

  def perform(boosting_id)
    PriorityBoosting.find(boosting_id).active!
  end
end
