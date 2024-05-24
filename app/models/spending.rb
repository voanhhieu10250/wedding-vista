class Spending < ApplicationRecord
  belongs_to :vendor

  validates :amount, :kind, presence: true

  enum kind: { post_limit: "POST_LIMIT", boost_limit: "BOOST_LIMIT" }
end
