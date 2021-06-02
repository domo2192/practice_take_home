require 'rails_helper'

RSpec.describe Customertea, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :tea }
  end
end
