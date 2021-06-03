class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :current_status,
             :subscription_title,
             :subscription_price,
             :subscription_frequency
end
