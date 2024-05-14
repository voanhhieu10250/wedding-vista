class Gallery < ApplicationRecord
  belongs_to :service
  has_many_attached :items do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200], preprocessed: true
  end
end
