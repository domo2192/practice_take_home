class Customer < ApplicationRecord
  has_many :customersubscriptions, dependent: :destroy
  has_many :customerteas, dependent: :destroy
  has_many :subscriptions, through: :customersubscriptions
  has_many :teas, through: :customerteas
  validates :email, uniqueness: true, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  before_save { email.try(:downcase!) }
end
