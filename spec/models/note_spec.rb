require 'rails_helper'

RSpec.describe Note, type: :model do

  describe 'associations' do
    it { should belong_to(:recipe) }
  end

end
