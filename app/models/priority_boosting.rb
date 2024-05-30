class PriorityBoosting < ApplicationRecord
  belongs_to :service

  validates :level, :status, presence: true

  enum status: { pending: "PENDING", active: "ACTIVE", expired: "EXPIRED" }
end
