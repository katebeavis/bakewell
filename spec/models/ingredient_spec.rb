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

  describe '#convert_price_into_pennies' do
    it 'converts price into pennies' do
      expect(subject.convert_price_into_pennies).to eq(250)
    end

    it 'converts prices beginning with 0 into pennies' do
      params[:price] = 0.50
      expect(subject.convert_price_into_pennies).to eq(50)
    end
  end

  describe '#update_unit_price_column' do
    it 'updates the unit price column with the correct amount per unit' do
      expect(subject.update_unit_price_column).to eq(0.00625)
    end
  end

  describe '#save' do
    it 'saves the price per unit' do
      expect {
        subject.save
      }.to change(subject, :unit_price).from(nil).to(0.00625)
    end
  end
end
