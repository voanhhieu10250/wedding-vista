class Address < ApplicationRecord
  belongs_to :service

  has_one :main_service, class_name: "Service", foreign_key: "main_address_id", dependent: :nullify

  validates :full_address, presence: true
end
