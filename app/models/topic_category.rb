class TopicCategory < ApplicationRecord
  has_many :topics, dependent: :destroy

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [80, 80], preprocessed: true
  end

  validates :image, content_type: %i[image/png image/jpg image/jpeg], size: { less_than: 500.kilobytes }
  validates :name, :image, presence: true
end
