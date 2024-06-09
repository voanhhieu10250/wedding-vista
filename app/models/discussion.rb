class Discussion < ApplicationRecord
  belongs_to :forum, counter_cache: true
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, source: :user

  has_rich_text :body

  validates :title, :body, :forum_id, :user_id, presence: true
end
