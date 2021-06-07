class ReviewFacade
  class << self

    def clean_reviews(tea_reviews, customer_id)
      tea_reviews.map do |review|
        CustomerTeaReview.create(customer_id: customer_id, tea_id: review[:tea_id],
                                 rating: review[:rating], review: review[:review])
      end
    end
  end
end
