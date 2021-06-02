class Customersubscription < ApplicationRecord
  belongs_to :subscription
  belongs_to :customer
  validates :status, presence: true
  enum status: [:inactive, :active, :cancelled]
end
