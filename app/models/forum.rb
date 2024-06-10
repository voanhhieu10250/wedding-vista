class Forum < ApplicationRecord
  has_many :discussions, dependent: :destroy
  # has_many :commenters, -> { distinct }, through: :discussions

  has_one_attached :image do |attachable|
    attachable.variant :header_bg, resize_to_fit: [1696, 256], preprocessed: true if attachable.present?
  end

  validates :title, :description, presence: true
end
