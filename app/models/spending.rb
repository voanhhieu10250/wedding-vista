class Spending < ApplicationRecord
  belongs_to :vendor

  validates :amount, :kind, presence: true

  enum kind: { post_limit: "POST_LIMIT", service_boosting: "SERVICE_BOOSTING" }
end
