class Transaction < ApplicationRecord
  belongs_to :vendor

  validates :description, :amount, presence: true

  enum status: { pending: "PENDING", paid: "PAID", cancelled: "CANCELLED" }
end
