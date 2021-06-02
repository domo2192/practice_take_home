class Subscription < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
  has_many :customers, through: :customer_subscriptions
  validates :title, presence: true
  validates :price, presence: true
  validates :frequency, presence: true
end
