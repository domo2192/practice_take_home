class Customer < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
  has_many :customer_tea_reviews, dependent: :destroy
  has_many :subscriptions, through: :customer_subscriptions
  has_many :teas_subscriptions, through: :customer_subscriptions
  has_many :teas, through: :customer_tea_reviews
  validates :email, uniqueness: true, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  before_save { email.try(:downcase!) }
end
