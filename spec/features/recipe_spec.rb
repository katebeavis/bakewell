require 'rails_helper'
require './spec/support/features/login_macros.rb'
include LoginMacros

RSpec.describe 'Recipe page', type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  context 'adding a recipe' do
    before do
      sign_in(user)
    end

    scenario 'adding a recipe' do
      
      visit recipes_path
      
      expect(page).to have_content(user.name)
      expect(page).to have_content('Looks like you haven\'t added any recipes yet! Click add recipe to get started')
      
      click_link 'Add recipe'

      expect(page).to have_content('What would you like to call your recipe?')

      new_recipe_page = Pages::NewRecipe.new

      new_recipe_page.fill_in_title

      new_recipe_page.fill_in_ingredient(0, 'Sugar', 200, 'g', 1.50, 1, 'kg')

      new_recipe_page.fill_in_ingredient(1, 'Butter', 100, 'g', 2, 250, 'g')

      new_recipe_page.fill_in_ingredient(2, 'Flour', 500, 'g', 2, 1.50, 'kg')

      new_recipe_page.fill_in_ingredient(3, 'Egg', 2, 'unit', 1, 10, 'unit')

      click_button 'Create recipe'

      expect(page).to have_current_path(recipe_path(Recipe.last))
      expect(page).to have_content('Mini Bakewells')
      expect(page).to have_content('Cost: £1.97')
      expect(page).to have_content('Sugar')
      expect(page).to have_content('200g')
      expect(page).to have_content('£0.30')
      expect(page).to have_content('£0.15/100g')
    end
  end
end
