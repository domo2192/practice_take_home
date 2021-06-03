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
      customer.customer_subscriptions.first.update!(status: 'cancelled')
      customer.customer_subscriptions.second.update!(status: 'inactive')
      get "/api/v1/customers/#{customer.id}/subscriptions"

      subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]
      subscriptions.each do |subscription|
        expect(subscription[:type]).to eq('subscription')
        expect(subscription[:attributes]).to be_a(Hash)
        expect(subscription[:attributes][:current_status]).to be_a(String)
        expect(subscription[:attributes][:subscription_title]).to be_a(String)
        expect(subscription[:attributes][:subscription_price]).to be_a(String)
        expect(subscription[:attributes][:subscription_frequency]).to be_a(String)
      end
    end
  end

  it 'errors out if you pass in a string as the customer id' do
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
    customer.customer_subscriptions.first.update!(status: 'cancelled')
    customer.customer_subscriptions.second.update!(status: 'inactive')
    get "/api/v1/customers/#{1}/subscriptions"
    errors = JSON.parse(response.body, symbolize_names: true)
    expect(errors).to be_a(Hash)
    expect(errors[:error]).to eq("Couldn't find Customer with 'id'=1")
  end
end
