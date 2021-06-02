class Tea < ApplicationRecord
  has_many :customerteas, dependent: :destroy
  has_many :customers, through: :customerteas
  validates :title, presence: true
  validates :description, presence: true
  validates :temperature, presence: true, numericality: {
            greater_than_or_equal_to: 0
          }
  validates :brew_time, presence: true
end
