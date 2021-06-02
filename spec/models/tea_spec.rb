require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'relationships' do
    it { should have_many :customerteas }
    it { should have_many(:customers).through(:customerteas) }
  end
end
