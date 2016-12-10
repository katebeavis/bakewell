require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject { described_class.new params }

  let(:recipe) { Recipe.create }
  let(:user) { FactoryGirl.create(:user_with_recipe) }
  let(:params) do
    {
      name: 'Mini Bakewells',
      quantity: 8,
      user_id: user.id,
      ingredients_attributes: {"0": { name: 'Sugar', amount: 100, price: 2.50, size: 100, unit_price: 2.50, amount_unit_of_measurement: 'g', size_unit_of_measurement: 'g' },
                               "1": { name: 'Sugar', amount: 100, price: 2.50, size: 100, unit_price: 1, amount_unit_of_measurement: 'g', size_unit_of_measurement: 'g' }},
    }
  end
  
  describe 'associations' do
    it { should have_many(:ingredients) }

    it { should belong_to(:user) }

    it { should have_many(:notes) }
  end

  describe '#valid?' do
    context 'happy path' do
      specify 'returns true' do
        expect(subject.valid?).to eq(true)
      end
    end

    context 'when name is blank' do
      before do
        params.merge! name: ''
      end

      specify 'returns false' do
        expect(subject.valid?).to eq(false)
      end
    end
  end

  describe '#calculate_cost' do
    it 'calculates the cost of a recipe' do
      expect(subject.calculate_cost).to eq(3.50)
    end
  end

  describe '#calculate_portion_cost' do
    it 'calculates the cost of a portion' do
      expect(subject.calculate_portion_cost).to eq(0.44)
    end
  end
end
