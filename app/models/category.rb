class Category < ApplicationRecord
  has_many :services, dependent: :nullify
  has_one_attached :image do |attachable|
    attachable.variant :header_bg, resize_to_fit: [2400, 588], preprocessed: true if attachable.present?
    attachable.variant :thumb, resize_to_fit: [270, 110] if attachable.present?
  end
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  # override to_param to make model_path construct a path using the model’s name instead of the model’s id
  # by default, values longer than 20 characters will be truncated. The value is truncated word by word.
  to_param :name
end
