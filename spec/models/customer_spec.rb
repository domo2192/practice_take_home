require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :customersubscriptions }
    it { should have_many(:subscriptions).through(:customersubscriptions) }
    it { should have_many :customerteas }
    it { should have_many(:teas).through(:customerteas) }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :address }
  end
end
