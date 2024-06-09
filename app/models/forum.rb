class Forum < ApplicationRecord
  has_many :discussions, dependent: :destroy
  has_many :commenters, -> { distinct }, through: :discussions

  validates :title, :description, presence: true
end
