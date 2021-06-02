require 'rails_helper'

describe 'New Customer Subscription' do
  describe 'happy path' do
    it 'can subscribe customers to subscriptions' do
      customer = create(:customer)
      gold = Subscription.create!(title: 'gold', price: '25.99', frequency: 'weekly')
      silver = Subscription.create!(title: 'silver', price: '15.99', frequency: 'weekly')
      copper = Subscription.create!(title: 'copper', price: '10.99', frequency: 'weekly')
      surprise = Subscription.create!(title: 'random', price: '12.99', frequency: 'weekly')
      create_list(:tea, 20, tea_price: 2.99)
      create_list(:tea, 20, tea_price: 1.99)
      create_list(:tea, 20, tea_price: 2.50)
      subscription_params = {subscription: 'gold'}
      headers     = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/customers/#{customer.id}/subscriptions", headers:headers, params: JSON.generate(subscription_params)

      expect(response).to be_successful
      customer_subscription = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(customer_subscription).to eq("Subscription created successfully.")
      created_subscription = CustomerSubscription.last
      subscription_teas = TeaSubscription.where("customer_subscription_id = #{created_subscription.id}")
      expect(subscription_teas.count).to eq(10)
      subscription_teas.each do |tea|
        tea = Tea.find(tea.tea_id)
        expect(tea.tea_price).to eq(2.99)
      end
    end

    it 'can subscribe to the different subscriptions' do
      customer = create(:customer)
      gold = Subscription.create!(title: 'gold', price: '25.99', frequency: 'weekly')
      silver = Subscription.create!(title: 'silver', price: '15.99', frequency: 'weekly')
      copper = Subscription.create!(title: 'copper', price: '10.99', frequency: 'weekly')
      surprise = Subscription.create!(title: 'random', price: '12.99', frequency: 'weekly')
      create_list(:tea, 20, tea_price: 2.99)
      create_list(:tea, 20, tea_price: 1.99)
      create_list(:tea, 20, tea_price: 2.50)
      subscription_params = {subscription: 'silver'}
      headers     = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/customers/#{customer.id}/subscriptions", headers:headers, params: JSON.generate(subscription_params)
      expect(response).to be_successful
      customer_subscription = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(customer_subscription).to eq("Subscription created successfully.")
      created_subscription = CustomerSubscription.last
      subscription_teas = TeaSubscription.where("customer_subscription_id = #{created_subscription.id}")
      expect(subscription_teas.count).to eq(10)
      subscription_teas.each do |tea|
        tea = Tea.find(tea.tea_id)
        expect(tea.tea_price).to be >= 2.50
      end
    end
  end

  describe 'sad path' do
    it 'errors out if given a customer who is not registered' do
      customer = create(:customer)
      gold = Subscription.create!(title: 'gold', price: '25.99', frequency: 'weekly')
      silver = Subscription.create!(title: 'silver', price: '15.99', frequency: 'weekly')
      copper = Subscription.create!(title: 'copper', price: '10.99', frequency: 'weekly')
      surprise = Subscription.create!(title: 'random', price: '12.99', frequency: 'weekly')
      create_list(:tea, 20, tea_price: 2.99)
      create_list(:tea, 20, tea_price: 1.99)
      create_list(:tea, 20, tea_price: 2.50)
      subscription_params = {subscription: 'silver'}
      headers     = { 'CONTENT_TYPE' => 'application/json' }
      post "/api/v1/customers/#{1}/subscriptions", headers:headers, params: JSON.generate(subscription_params)
      expect(response.status).to eq(404)
      failed_subscription = JSON.parse(response.body, symbolize_names: true)
      expect(failed_subscription[:error]).to eq("Couldn't find Customer with 'id'=1")

    end

    it 'errors out if given a subscription that is not registered' do
      customer = create(:customer)
      gold = Subscription.create!(title: 'gold', price: '25.99', frequency: 'weekly')
      silver = Subscription.create!(title: 'silver', price: '15.99', frequency: 'weekly')
      copper = Subscription.create!(title: 'copper', price: '10.99', frequency: 'weekly')
      surprise = Subscription.create!(title: 'random', price: '12.99', frequency: 'weekly')
      create_list(:tea, 20, tea_price: 2.99)
      create_list(:tea, 20, tea_price: 1.99)
      create_list(:tea, 20, tea_price: 2.50)
      subscription_params = {subscription: 'purple'}
      headers     = { 'CONTENT_TYPE' => 'application/json' }
      post "/api/v1/customers/#{customer.id}/subscriptions", headers:headers, params: JSON.generate(subscription_params)
      expect(response.status).to eq(400)
      failed_subscription = JSON.parse(response.body, symbolize_names: true)
      expect(failed_subscription[:error]).to eq('Enter a valid subscription type')
    end
  end
end
