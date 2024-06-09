class Comment < ApplicationRecord
  belongs_to :discussion
  belongs_to :user

  belongs_to :parent_comment, class_name: "Comment", optional: true

  has_rich_text :body
end
