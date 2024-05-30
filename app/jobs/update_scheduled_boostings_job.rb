class UpdateScheduledBoostingsJob < ApplicationJob
  queue_as :default

  def perform
    PriorityBoosting.where(["start_time <= :now AND end_time > :now AND status != 'ACTIVE'",
                            { now: Time.zone.now }]).each do |boosting|
      ActivateBoostingJob.perform_later(boosting.id)
    end

    PriorityBoosting.where(["end_time <= :now AND status != 'EXPIRED'",
                            { now: Time.zone.now }]).each do |boosting|
      ExpireBoostingJob.perform_later(boosting.id)
    end
  end
end
