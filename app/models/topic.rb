class Topic < ApplicationRecord
  belongs_to :topic_category
  has_many :ideas, dependent: :nullify

  validates :name, :description, presence: true
end
