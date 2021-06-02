class Customer < ApplicationRecord
  has_many :customersubscriptions, dependent: :destroy
  has_many :customerteas, dependent: :destroy
  has_many :subscriptions, through: :customersubscriptions
  has_many :teas, through: :customerteas
end
