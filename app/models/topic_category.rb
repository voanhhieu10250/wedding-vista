class TopicCategory < ApplicationRecord
  has_many :topics, dependent: :destroy
  has_many :ideas, through: :topics

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [80, 80], preprocessed: true if attachable.present?
  end

  validates :image, content_type: %i[image/png image/jpg image/jpeg], size: { less_than: 500.kilobytes }
  validates :name, :description, presence: true

  # Topic.find_each {|t| Topic.reset_counters(t.id, :ideas)}
end
