class Category < ApplicationRecord
  has_many :services, dependent: :nullify
  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :slug, presence: true, uniqueness: true
end
