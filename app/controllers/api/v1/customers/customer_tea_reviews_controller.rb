class Api::V1::Customers::CustomerTeaReviewsController < ApplicationController
  before_action :validate_customer_review, only: [:create]
  before_action :validate_customer, only: [:create]

  def create
    clean_reviews = ReviewFacade.clean_reviews(params[:_json], params[:id])
    render json: { data: "We appreciate your reviews!"}, status: :created
  end



  private
  def validate_customer_review
    if params[:id] == nil || params[:id].empty?
      error = 'That id is not a valid customer id.'
      render_error(error)
    end
  end
end
