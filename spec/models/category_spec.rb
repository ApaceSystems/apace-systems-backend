require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { build(:category) }

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'Associations' do
    it { should have_many(:products).dependent(:destroy) }
  end
end
