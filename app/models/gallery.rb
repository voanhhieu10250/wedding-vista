class Gallery < ApplicationRecord
  belongs_to :service
  has_many_attached :items do |attachable|
    if attachable.present?
      attachable.variant :thumb, resize_to_limit: [128, 128], preprocessed: true
      attachable.variant :medium, resize_to_limit: [640, 640], preprocessed: true
    end
  end

  validates :name, presence: true
  validates :items, content_type: %r{\Aimage/.*\z}

  to_param :name
end
