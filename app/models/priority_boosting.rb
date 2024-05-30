class PriorityBoosting < ApplicationRecord
  belongs_to :service

  validates :level, :status, presence: true

  enum status: { pending: "PENDING", active: "ACTIVE", expired: "EXPIRED" }

  def update_times_and_job(start_time, end_time)
    SolidQueue::Job.find_by(active_job_id: job_id)&.destroy! if job_id.present?
    job_id = ActivateBoostingJob.set(wait_until: start_time).perform_later(id)

    update(start_time:, end_time:, job_id:)
  end
end
