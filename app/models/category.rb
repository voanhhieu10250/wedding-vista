class Category < ApplicationRecord
  has_many :services, dependent: :nullify
  validates :name, presence: true, length: { minimum: 5, maximum: 50 }

  # override to_param to make model_path construct a path using the model’s name instead of the model’s id
  # by default, values longer than 20 characters will be truncated. The value is truncated word by word.
  to_param :name
end
