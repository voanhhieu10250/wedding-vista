class Gallery < ApplicationRecord
  include Attachments

  belongs_to :service, touch: true
  has_many_attached :items do |attachable|
    if attachable.present?
      attachable.variant :thumb, resize_to_limit: [128, 128], preprocessed: true
      attachable.variant :medium, resize_to_limit: [640, 640], preprocessed: true
    end
  end

  validates :name, presence: true
  validates :items, content_type: %r{\Aimage/.*\z}

  to_param :name

  # Gallery.find_each {|g| g.reset_attachment_counter}
  def reset_attachment_counter
    attachment_count = ActiveStorage::Attachment.where(record_type: "Gallery", record_id: id).count
    update_column(:attachments_count, attachment_count)
  end

  def first_four_items
    items.limit(4)
  end
end
