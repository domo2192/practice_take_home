class CustomerTeaReview < ApplicationRecord
  belongs_to :customer
  belongs_to :tea
  validates :rating, presence: true
  validates :review, presence: true
end
