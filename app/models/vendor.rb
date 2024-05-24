class Vendor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :services, dependent: :destroy
  has_many :ideas, dependent: :nullify
  has_many :transactions, dependent: :destroy
  has_many :spendings, dependent: :destroy
  has_one_attached :avatar
end
