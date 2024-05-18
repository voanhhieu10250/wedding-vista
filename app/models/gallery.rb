class Gallery < ApplicationRecord
  belongs_to :service
  has_many_attached :items do |attachable|
    attachable.variant :thumb, resize_to_limit: [128, 128], preprocessed: true
  end

  validates :name, presence: true
  validates :items, content_type: %r{\Aimage/.*\z}

  to_param :name
end
