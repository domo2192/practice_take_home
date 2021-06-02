class Tea < ApplicationRecord
  has_many :customer_tea_reviews, dependent: :destroy
  has_many :customers, through: :customer_tea_reviews
  has_many :tea_subscriptions
  validates :title, presence: true
  validates :description, presence: true
  validates :temperature, presence: true, numericality: {
            greater_than_or_equal_to: 0
          }
  validates :brew_time, presence: true


  def self.find_teas(subscription, customer_subscription_id)
    if subscription == 'gold'
      teas = Tea.where('tea_price > ?', 2.50 ).order("RANDOM()").limit(10)
    elsif subscription == 'silver'
      teas = Tea.where('tea_price > ?', 2.00 ).order("RANDOM()").limit(10)
    elsif subscription == 'copper'
      teas = Tea.where('tea_price < ?', 2.00 ).order("RANDOM()").limit(10)
    else
      teas = Tea.all.order("RANDOM()").limit(10)
    end
   TeaSubscription.make_tea_subscriptions(teas, customer_subscription_id)
  end
end
