require 'rails_helper'

RSpec.describe CustomerTeaReview, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :tea }
  end
  describe 'validations' do
    it { should validate_presence_of :rating }
    it { should validate_presence_of :review }
  end
end
