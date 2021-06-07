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

    def format_cancels(tea_subscriptions)
      tea_subscriptions.map do |sub|
        OpenStruct.new(id: sub.tea.id,
                   title: sub.tea.title,
             description: sub.tea.description,
             temperature: sub.tea.temperature,
               brew_time: sub.tea.brew_time,
               tea_price: sub.tea.tea_price)
      end
    end
  end
end
