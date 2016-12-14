require 'rails_helper'

RSpec.describe 'Recipe page', type: :feature do
  context 'adding a recipe' do
    let!(:user) do
      create :user
    end

    scenario 'adding a recipe' do
      
      visit '/'

      click_link 'Get started'

      expect(page).to have_content('Log in')
    end
  end
end
