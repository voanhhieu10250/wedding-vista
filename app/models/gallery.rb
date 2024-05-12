class Gallery < ApplicationRecord
  belongs_to :service
  has_one_attached :content
end
