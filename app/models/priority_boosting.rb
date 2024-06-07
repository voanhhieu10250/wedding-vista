class PriorityBoosting < ApplicationRecord
  belongs_to :service

  validates :level, :status, presence: true

  enum status: { pending: "PENDING", active: "ACTIVE", expired: "EXPIRED" }

  after_destroy :destroy_job

  # This method is used to update the start_time, end_time, and job_id of the priority boosting
  # Like if we want to update the start_time and end_time of the priority boosting
  # It will also destroy the old job if it exists
  def update_times_and_job(start_time, end_time, create_job: false)
    SolidQueue::Job.find_by(active_job_id: job_id)&.destroy! if job_id.present?

    if create_job
      job_id = ActivateBoostingJob.set(wait_until: start_time).perform_later(id)
      update(start_time:, end_time:, job_id:, created_at: Time.zone.now)
    else
      update(start_time:, end_time:, job_id: nil, status: "ACTIVE", created_at: Time.zone.now)
    end
  end

  private

  def destroy_job
    SolidQueue::Job.find_by(active_job_id: job_id)&.destroy! if job_id.present?
  end
end
