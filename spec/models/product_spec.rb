require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build(:product) }

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0).allow_nil }
  end

  describe 'Associations' do
    it { should belong_to(:category) }
  end
end
