require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should have_many :customers }
    it { should have_many(:customers).through(:customer_subscriptions) }
  end
end
