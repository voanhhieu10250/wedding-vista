class Idea < ApplicationRecord
  ALLOWED_IMAGE_TYPES = %w[image/png image/jpg image/jpeg image/gif]

  belongs_to :vendor
  belongs_to :topic

  has_rich_text :content
  has_one_attached :main_image do |attachable|
    attachable.variant :thumbnail, resize_to_limit: [604, 427], preprocessed: true
  end

  validates :main_image, content_type: %i[image/png image/jpg image/jpeg], size: { less_than: 10.megabytes }
  validates :title, :description, :main_image, presence: true
  validate :content_has_allowed_image_type

  def to_param
    "#{id}-#{title&.parameterize}"
  end

  private

  def content_has_allowed_image_type
    content.body.attachables.each do |attachment|
      unless ALLOWED_IMAGE_TYPES.include? attachment.content_type
        errors.add(:content, "includes unsupported image type")
      end

      errors.add(:content, "includes image larger than 10MB") unless attachment.byte_size < 10.megabytes
    end
  end
end
