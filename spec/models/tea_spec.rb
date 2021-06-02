require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'relationships' do
    it { should have_many :customer_teas }
    it { should have_many(:customers).through(:customer_teas) }
  end
end
