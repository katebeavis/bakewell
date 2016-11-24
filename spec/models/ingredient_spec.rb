require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  subject { described_class.new params }

  let(:ingredient) { Ingredient.create }
  let(:recipe) { FactoryGirl.create :recipe }
  let(:params) do
    {
      name: 'Sugar',
      amount: 200,
      price: 2.5,
      size: 400,
      recipe_id: recipe.id
    }
  end

  describe 'associations' do
    it { should belong_to(:recipe) }
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

    context 'when amount is blank' do
      before do
        params.merge! amount: ''
      end

      specify 'returns false' do
        expect(subject.valid?).to eq(false)
      end
    end

    context 'when price is blank' do
      before do
        params.merge! price: ''
      end

      specify 'returns false' do
        expect(subject.valid?).to eq(false)
      end
    end

    context 'when size is blank' do
      before do
        params.merge! size: ''
      end

      specify 'returns false' do
        expect(subject.valid?).to eq(false)
      end
    end
  end

  describe '#calculate_price_per_amount' do
    it 'correctly calculates the price per amount' do
      expect(subject.calculate_price_per_amount).to eq(1.25)
    end
  end

  describe '#calculate_price_per_unit' do
    it 'correctly calculates the price per unit' do
      expect(subject.calculate_price_per_unit).to eq(0.00625)
    end
  end

  describe '#save' do
    it 'saves the price per unit' do
      expect {
        subject.save
      }.to change(subject, :unit_price).from(nil).to(1.25)
    end
  end
end
