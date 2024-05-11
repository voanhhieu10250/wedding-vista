class Service < ApplicationRecord
  belongs_to :vendor
  belongs_to :category, optional: true

  validates :name, presence: true
end
