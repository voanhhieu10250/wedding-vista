class Service < ApplicationRecord
  belongs_to :vendor
  belongs_to :category, optional: true
  has_many :galleries, dependent: :destroy

  validates :name, presence: true
end
