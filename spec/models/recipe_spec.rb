require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject { described_class.new params }

  let(:recipe) { Recipe.create }
  let(:params) do
    {
      name: 'Mini Bakewells'
    }
  end
  
  describe 'associations' do
    it { should have_many(:ingredients) }
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
end
