class Topic < ApplicationRecord
  belongs_to :topic_category
  has_many :ideas
end
