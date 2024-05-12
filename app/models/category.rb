class Category < ApplicationRecord
  has_many :services, dependent: :nullify
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
end
