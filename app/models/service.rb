class Service < ApplicationRecord
  belongs_to :vendor
  belongs_to :category, optional: true
  has_many :galleries, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_one :main_address, dependent: :destroy

  validates :name, :description, :category_id, presence: true
end
