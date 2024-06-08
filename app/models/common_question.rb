class CommonQuestion < ApplicationRecord
  belongs_to :service

  validates :question, presence: true
  validate :validate_common_questions_count

  private

  def validate_common_questions_count
    return if service.common_questions.count < 10

    errors.add(:base, "You can't create more than 10 common questions.")
  end
end
