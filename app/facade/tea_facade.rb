class TeaFacade
  class << self

    def format_subscriptions(customer_subscriptions)
      customer_subscriptions.map do |sub|
        OpenStruct.new(            id: sub.id,
                       current_status: sub.status,
                   subscription_title: sub.subscription.title,
                   subscription_price: sub.subscription.price,
               subscription_frequency: sub.subscription.frequency)
      end
    end
  end
end
