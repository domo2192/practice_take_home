class Api::V1::Customers::CustomerSubscriptionsController < ApplicationController
  before_action :validate_id, only: [:create]
  before_action :validate_customer, only: [:create]
  before_action :validate_subscription, only: [:create]

  def create
    sub = Subscription.find_by(title: params['subscription'])
    customer_subscription = CustomerSubscription.create(customer_id: params[:id], subscription_id: sub.id)
    teas = Tea.find_teas(params['subscription'], customer_subscription.id)
    render json: { data: "Subscription created successfully."}, status: :created
  end


  private
  def validate_subscription
    if params[:subscription] == nil || params[:subscription].empty? || Subscription.find_by(title: params['subscription']) == nil 
      error = 'Enter a valid subscription type'
      render_error(error)
    end
  end
end
