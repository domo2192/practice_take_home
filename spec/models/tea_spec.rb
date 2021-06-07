require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'relationships' do
    it { should have_many :customer_tea_reviews }
    it { should have_many(:customers).through(:customer_tea_reviews)}
  end
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :temperature }
    it { should validate_presence_of :brew_time }
  end

  describe 'class methods ' do
    it 'can return based on prices' do
      customer = create(:customer)
      gold = Subscription.create!(title: 'gold', price: '25.99', frequency: 'weekly')
      silver = Subscription.create!(title: 'silver', price: '15.99', frequency: 'weekly')
      copper = Subscription.create!(title: 'copper', price: '10.99', frequency: 'weekly')
      surprise = Subscription.create!(title: 'random', price: '12.99', frequency: 'weekly')
      create_list(:tea, 20, tea_price: 2.99)
      create_list(:tea, 20, tea_price: 1.99)
      create_list(:tea, 20, tea_price: 2.50)
      customer_sub = CustomerSubscription.create(customer_id: customer.id, subscription_id: gold.id)
      create_subs = Tea.find_teas('gold', customer_sub.id)
      create_subs.map do |sub|
        expect(sub.tea.tea_price).to be > 2.50
      end
    end
  end
end
