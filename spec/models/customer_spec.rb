require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :customersubscriptions }
    it { should have_many(:subscriptions).through(:customersubscriptions) }
    it { should have_many :customerteas }
    it { should have_many(:teas).through(:customerteas) }
  end
end
