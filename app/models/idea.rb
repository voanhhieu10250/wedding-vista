class Idea < ApplicationRecord
  belongs_to :vendor, optional: true
  belongs_to :topic, optional: true

  has_rich_text :content
  has_one_attached :main_image do |attachable|
    attachable.variant :thumbnail, resize_to_limit: [604, 427], preprocessed: true if attachable.present?
  end

  validates :main_image, content_type: %i[image/png image/jpg image/jpeg image/webp],
                         size: { less_than: 10.megabytes }
  validates :title, :description, presence: true
  validate :content_has_allowed_image_type

  def to_param
    "#{id}-#{title&.parameterize}"
  end

  private

  def content_has_allowed_image_type
    content.body.attachments.each do |attachment|
      unless attachment.byte_size <= 1.megabyte
        errors.add(:content, "includes image larger than 10MB")
        # attachment.purge # or use another approach to handle invalid attachments
      end

      acceptable_types = %w[image/png image/jpg image/jpeg image/gif image/webp]
      unless acceptable_types.include?(attachment.content_type)
        errors.add(:content, "includes unsupported image type")
        # attachment.purge # or use another approach to handle invalid attachments
      end
    end
  end
end
