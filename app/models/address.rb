class Address < ApplicationRecord
  belongs_to :service

  validates :full_address, presence: true
end
