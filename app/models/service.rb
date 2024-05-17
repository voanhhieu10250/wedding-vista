class Service < ApplicationRecord
  belongs_to :vendor
  belongs_to :category, optional: true

  has_many :galleries, dependent: :destroy
  has_many :common_questions, dependent: :destroy
  has_many :addresses, dependent: :destroy, inverse_of: :service
  accepts_nested_attributes_for :addresses, reject_if: :all_blank, allow_destroy: true

  has_one :main_address, dependent: :destroy

  validates :name, :description, :category_id, presence: true
  validates :name, length: { maximum: 255 }
end
