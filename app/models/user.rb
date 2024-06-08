class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :reviewed_services, through: :reviews, source: :service

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100], preprocessed: true if attachable.present?
  end

  validates :name, presence: true
  validates :avatar, content_type: %i[image/png image/jpg image/jpeg], size: { less_than: 500.kilobytes }
end
