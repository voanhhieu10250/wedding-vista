class Transaction < ApplicationRecord
  belongs_to :vendor

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 10_000 }
  validate :multiple_of_one_thousand

  enum status: { pending: "PENDING", paid: "PAID", cancelled: "CANCELLED" }

  private

  def multiple_of_one_thousand
    return unless amount.present? && amount % 1000 != 0

    errors.add(:amount, "must be a positive multiple of 1,000")
  end
end
