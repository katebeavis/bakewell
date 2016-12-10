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
      amount_unit_of_measurement: 'g',
      size_unit_of_measurement: 'g',
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

    context 'when amount unit of measurement is blank' do
      before do
        params.merge! amount_unit_of_measurement: ''
      end

      specify 'returns false' do
        expect(subject.valid?).to eq(false)
      end
    end

    context 'when size unit of measurement is blank' do
      before do
        params.merge! size_unit_of_measurement: ''
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

  describe 'save' do

    context 'update unit price column' do
      it 'saves the price per unit' do
        expect {
          subject.save
        }.to change(subject, :unit_price).from(nil).to(1.25)
      end
    end

    context 'update size unit column' do
      context 'kg' do
        it 'saves the converted size unit of measurement unit' do
          params[:size] = 1
          params[:size_unit_of_measurement] = 'kg'
          expect {
            subject.save
          }.to change(subject, :size).from(1).to(1000)
        end
      end

      context 'l' do
        it 'saves the converted size unit of measurement unit' do
          params[:size] = 1
          params[:size_unit_of_measurement] = 'l'
          expect {
            subject.save
          }.to change(subject, :size).from(1).to(1000)
        end
      end

      context 'g' do
        it 'does NOT save the converted size unit of measurement unit' do
          params[:size] = 1
          params[:size_unit_of_measurement] = 'g'
          expect {
            subject.save
          }.to_not change(subject, :size)
        end
      end

      context 'unit' do
        it 'does NOT save the converted size unit of measurement unit' do
          params[:size] = 1
          params[:size_unit_of_measurement] = 'unit'
          expect {
            subject.save
          }.to_not change(subject, :size)
        end
      end
    end

    context 'update amount unit column' do
      context 'kg' do
        it 'saves the converted amount unit of measurement unit' do
          params[:amount] = 1
          params[:amount_unit_of_measurement] = 'kg'
          expect {
            subject.save
          }.to change(subject, :amount).from(1).to(1000)
        end
      end

      context 'l' do
        it 'saves the converted amount unit of measurement unit' do
          params[:amount] = 1
          params[:amount_unit_of_measurement] = 'l'
          expect {
            subject.save
          }.to change(subject, :amount).from(1).to(1000)
        end
      end

      context 'g' do
        it 'does NOT save the converted amount unit of measurement unit' do
          params[:amount] = 1
          params[:amount_unit_of_measurement] = 'g'
          expect {
            subject.save
          }.to_not change(subject, :size)
        end
      end

      context 'unit' do
        it 'does NOT save the converted amount unit of measurement unit' do
          params[:amount] = 1
          params[:amount_unit_of_measurement] = 'unit'
          expect {
            subject.save
          }.to_not change(subject, :size)
        end
      end
    end
  end
end
