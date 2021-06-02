class CustomerSubscription < ApplicationRecord
  belongs_to :subscription
  belongs_to :customer
  has_many :tea_subscriptions
  validates :status, presence: true
  enum status: [:active, :inactive, :cancelled]
end
