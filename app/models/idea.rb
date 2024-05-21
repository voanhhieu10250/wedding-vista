class Idea < ApplicationRecord
  belongs_to :vendor
  belongs_to :topic
  has_rich_text :body
end
