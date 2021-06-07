require 'rails_helper'

describe 'tea facade' do
  it 'can take in teasubscriptions' do
    customer = create(:customer)
    gold = Subscription.create!(title: 'gold', price: '25.99', frequency: 'weekly')
    silver = Subscription.create!(title: 'silver', price: '15.99', frequency: 'weekly')
    copper = Subscription.create!(title: 'copper', price: '10.99', frequency: 'weekly')
    surprise = Subscription.create!(title: 'random', price: '12.99', frequency: 'weekly')
    customer_sub = CustomerSubscription.create(customer_id: customer.id, subscription_id: gold.id)
    create_list(:tea, 20, tea_price: 2.99)
    create_list(:tea, 20, tea_price: 1.99)
    create_list(:tea, 20, tea_price: 2.50)
    tea_subs = create_list(:tea_subscription, 5, customer_subscription_id: customer_sub.id, tea_id: Tea.all.first.id)
    test = TeaFacade.format_cancels(tea_subs)
    test.each do |tea|
      expect(tea).to be_an(OpenStruct)
      expect(tea).to respond_to(:id)
      expect(tea).to respond_to(:title)
      expect(tea).to respond_to(:description)
      expect(tea).to respond_to(:temperature)
      expect(tea).to respond_to(:brew_time)
      expect(tea).to respond_to(:tea_price)
    end
  end

  it 'can take in format subscriptions' do
    customer = create(:customer)
    gold = Subscription.create!(title: 'gold', price: '25.99', frequency: 'weekly')
    silver = Subscription.create!(title: 'silver', price: '15.99', frequency: 'weekly')
    copper = Subscription.create!(title: 'copper', price: '10.99', frequency: 'weekly')
    surprise = Subscription.create!(title: 'random', price: '12.99', frequency: 'weekly')
    customer_sub = CustomerSubscription.create(customer_id: customer.id, subscription_id: gold.id)
    customer_sub2 = CustomerSubscription.create(customer_id: customer.id, subscription_id: silver.id)
    customer_sub3 = CustomerSubscription.create(customer_id: customer.id, subscription_id: copper.id)
    test = TeaFacade.format_subscriptions([customer_sub, customer_sub2, customer_sub3])
    expect(test.count).to eq(3)
    test.each do |tea|
      expect(tea).to be_an(OpenStruct)
      expect(tea).to respond_to(:id)
      expect(tea).to respond_to(:current_status)
      expect(tea).to respond_to(:subscription_title)
      expect(tea).to respond_to(:subscription_price)
      expect(tea).to respond_to(:subscription_frequency)
    end

  end
end
