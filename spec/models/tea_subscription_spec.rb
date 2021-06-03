require 'rails_helper'

RSpec.describe TeaSubscription, type: :model do
  describe 'relationships' do
    it { should belong_to :customer_subscription }
    it { should belong_to :tea }
    it { should have_many(:customers).through(:customer_subscription)}
  end

  describe 'class methods' do
    it 'can make tea subscriptions' do
      customer = create(:customer)
      gold = Subscription.create!(title: 'gold', price: '25.99', frequency: 'weekly')
      customer_subscription = CustomerSubscription.create(customer_id: customer.id ,subscription_id: gold.id)
      teas = create_list(:tea, 10, tea_price: 2.99)
      tea_subs = TeaSubscription.make_tea_subscriptions(teas, customer_subscription.id)
      expect(tea_subs.count).to eq(10)
      tea_subs.each do |tea|
        expect(tea.customer_subscription_id).to eq(customer_subscription.id)
      end 
    end
  end
end
