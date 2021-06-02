class TeaSubscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer_subscription
  has_many :customers, through: :customer_subscriptions

  def self.make_tea_subscriptions(teas, customer_subscription_id)
    teas.each do |tea|
      TeaSubscription.create(tea_id: tea.id, customer_subscription_id: customer_subscription_id)
    end
  end
end
