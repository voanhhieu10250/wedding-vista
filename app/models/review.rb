class Review < ApplicationRecord
  belongs_to :service, counter_cache: true
  belongs_to :user

  validates :service_id, :user_id, :rating, :title, :body, presence: true
end
