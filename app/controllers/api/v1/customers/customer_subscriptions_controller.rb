class Api::V1::Customers::CustomerSubscriptionsController < ApplicationController
  before_action :validate_id, only: [:create, :update, :index]
  before_action :validate_customer, only: [:create, :index]
  before_action :validate_subscription, only: [:create]

  def create
    sub = Subscription.find_by(title: params['subscription'])
    customer_subscription = CustomerSubscription.create(customer_id: params[:id], subscription_id: sub.id)
    teas = Tea.find_teas(params['subscription'], customer_subscription.id)
    render json: { data: "Subscription created successfully."}, status: :created
  end

  def update
    customer_subscription = CustomerSubscription.find(params[:id])
    customer_subscription.status = 'cancelled'
    teas = TeaFacade.format_cancels(customer_subscription.tea_subscriptions)
    render json: TeaSerializer.new(teas)
  end

  def index
    customer_subscriptions = Customer.find(params[:id]).customer_subscriptions
    format_subscriptions = TeaFacade.format_subscriptions(customer_subscriptions)
    render json: SubscriptionSerializer.new(format_subscriptions)
  end


  private
  def validate_subscription
    if params[:subscription] == nil || params[:subscription].empty? || Subscription.find_by(title: params['subscription']) == nil
      error = 'Enter a valid subscription type'
      render_error(error)
    end
  end
end
