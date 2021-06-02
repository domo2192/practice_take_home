class Tea < ApplicationRecord
  has_many :customerteas, dependent: :destroy
  has_many :customers, through: :customerteas 
end
