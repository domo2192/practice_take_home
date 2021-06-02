class Subscription < ApplicationRecord
  has_many :customersubscriptions, dependent: :destroy
  has_many :customers, through: :customersubscriptions
  validates :title, presence: true
  validates :price, presence: true
  validates :frequency, presence: true
end
