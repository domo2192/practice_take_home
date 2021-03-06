require 'rails_helper'

describe 'Cancel Customer Subscription' do
  describe 'happy path' do
    it 'can cancel customers subscriptions' do
      customer = create(:customer)
      gold = Subscription.create!(title: 'gold', price: '25.99', frequency: 'weekly')
      silver = Subscription.create!(title: 'silver', price: '15.99', frequency: 'weekly')
      copper = Subscription.create!(title: 'copper', price: '10.99', frequency: 'weekly')
      surprise = Subscription.create!(title: 'random', price: '12.99', frequency: 'weekly')
      create_list(:tea, 20, tea_price: 2.99)
      create_list(:tea, 20, tea_price: 1.99)
      create_list(:tea, 20, tea_price: 2.50)
      subscription_params = {subscription: 'gold'}
      subscription_params2 = {subscription: 'silver'}
      subscription_params3 = {subscription: 'copper'}
      headers     = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/customers/#{customer.id}/subscriptions", headers:headers, params: JSON.generate(subscription_params)
      post "/api/v1/customers/#{customer.id}/subscriptions", headers:headers, params: JSON.generate(subscription_params2)
      post "/api/v1/customers/#{customer.id}/subscriptions", headers:headers, params: JSON.generate(subscription_params3)
      expect(customer.customer_subscriptions.count).to eq(3)
      customer.customer_subscriptions.each do |sub|
        expect(sub.status).to eq('active')
      end
      second_id = customer.customer_subscriptions.second.id
      patch "/api/v1/customers/#{customer.id}/subscriptions/#{second_id}", headers: headers

      expect(response).to be_successful
      cancelled_teas = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(cancelled_teas.count).to eq(10)
      cancelled_teas.each do |tea|
        expect(tea[:attributes]).to be_a(Hash)
        expect(tea[:type]).to eq("tea")
        expect(tea[:attributes][:title]).to be_a(String)
        expect(tea[:attributes][:description]).to be_a(String)
        expect(tea[:attributes][:temperature]).to be_a(Numeric)
        expect(tea[:attributes][:brew_time]).to be_a(String)
        expect(tea[:attributes][:tea_price]).to be_a(Numeric)
      end
    end
  end

  describe 'sad paths' do
    it 'errors out when incorrect customer id' do
      customer = create(:customer)
      gold = Subscription.create!(title: 'gold', price: '25.99', frequency: 'weekly')
      silver = Subscription.create!(title: 'silver', price: '15.99', frequency: 'weekly')
      copper = Subscription.create!(title: 'copper', price: '10.99', frequency: 'weekly')
      surprise = Subscription.create!(title: 'random', price: '12.99', frequency: 'weekly')
      create_list(:tea, 20, tea_price: 2.99)
      create_list(:tea, 20, tea_price: 1.99)
      create_list(:tea, 20, tea_price: 2.50)
      subscription_params = {subscription: 'gold'}
      subscription_params2 = {subscription: 'silver'}
      subscription_params3 = {subscription: 'copper'}
      headers     = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/customers/#{customer.id}/subscriptions", headers:headers, params: JSON.generate(subscription_params)
      post "/api/v1/customers/#{customer.id}/subscriptions", headers:headers, params: JSON.generate(subscription_params2)
      post "/api/v1/customers/#{customer.id}/subscriptions", headers:headers, params: JSON.generate(subscription_params3)
      expect(customer.customer_subscriptions.count).to eq(3)
      customer.customer_subscriptions.each do |sub|
        expect(sub.status).to eq('active')
      end
      second_id = customer.customer_subscriptions.second.id
      patch "/api/v1/customers/#{customer.id}/subscriptions/#{0}", headers: headers
      bad_request = JSON.parse(response.body, symbolize_names: true)
      expect(bad_request).to be_a(Hash)
      expect(bad_request[:message]).to eq("your request cannot be completed")
      expect(bad_request[:error]).to eq("String not accepted as id")
    end
  end
end
