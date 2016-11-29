require 'rails_helper'
include ApplicationHelper

RSpec.describe ApplicationHelper, type: :helper do
  subject { described_class }

  describe '#greeting' do
    context 'before 12:00' do
      before :each do
        morning = Time.zone.parse("10:00:00")
        Timecop.freeze(morning)
      end
      it 'returns a morning greeting' do
        expect(subject.greeting).to eq("Good morning")
      end
    end

    context 'between 12:00 and 17:00' do
      before :each do
        afternoon = Time.zone.parse("14:00:00")
        Timecop.freeze(afternoon)
      end
      it 'returns an afternoon greeting' do
        expect(subject.greeting).to eq("Good afternoon")
      end
    end

    context 'between 17:00 and 00:00' do
      before :each do
        evening = Time.zone.parse("20:00:00")
        Timecop.freeze(evening)
      end
      it 'returns an evening greeting' do
        expect(subject.greeting).to eq("Good evening")
      end
    end
  end
end
