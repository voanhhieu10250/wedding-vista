class CommonQuestion < ApplicationRecord
  belongs_to :service

  validates :question, presence: true
end
