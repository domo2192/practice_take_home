class Subscription < ApplicationRecord
  has_many :customersubscriptions, dependent: :destroy
  has_many :customers, through: :customersubscriptions 
end
