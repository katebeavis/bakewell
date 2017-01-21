require 'rails_helper'
require './spec/support/features/login_macros.rb'
include LoginMacros

RSpec.describe 'Recipe page', type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:new_recipe_page) { Pages::NewRecipe.new }

  context 'adding a recipe' do
    before do
      sign_in(user)
    end

    scenario 'removing ingredient fields' do
      visit recipes_path

      click_link 'Add recipe'

      new_recipe_page.fill_in_title

      find('.chevron-anchor-recipes').click

      new_recipe_page.fill_in_ingredient(0, 'Sugar', 200, 'g', 1.50, 1, 'kg')

      remove_links = page.all(".remove_fields")
      remove_links[1].click
      remove_links[2].click
      remove_links[3].click

      click_button 'Create recipe'
      expect(page).to have_content('Mini Bakewells')
      expect(page).to have_current_path(recipe_path(Recipe.last))
    end

    scenario 'adding a recipe' do
      
      visit recipes_path
      
      expect(page).to have_content(user.name)

      expect(page).to have_content('Looks like you haven\'t added any recipes yet! Click add recipe to get started')
      
      click_link 'Add recipe'

      expect(page).to have_content('What would you like to call your recipe?')

      new_recipe_page.fill_in_title

      find('.chevron-anchor-recipes').click

      new_recipe_page.fill_in_ingredient(0, 'Sugar', 200, 'g', 1.50, 1, 'kg')

      new_recipe_page.fill_in_ingredient(1, 'Butter', 100, 'g', 2, 250, 'g')

      new_recipe_page.fill_in_ingredient(2, 'Flour', 500, 'g', 2, 1.50, 'kg')

      new_recipe_page.fill_in_ingredient(3, 'Egg', 2, 'each', 1, 10, 'each')

      click_button 'Create recipe'

      expect(page).to have_current_path(recipe_path(Recipe.last))
      expect(page).to have_content('Mini Bakewells')
      expect(page).to have_content('Cost: £1.97')
      expect(page).to have_content('Sugar')
      expect(page).to have_content('200g')
      expect(page).to have_content('Butter')
      expect(page).to have_content('100g')
      expect(page).to have_content('Flour')
      expect(page).to have_content('500g')
      expect(page).to have_content('Egg')
      expect(page).to have_content('2')
    end

    xscenario 'adding ingredient fields' do
      visit recipes_path

      click_link 'Add recipe'

      new_recipe_page.fill_in_title

      find('.chevron-anchor-recipes').click

      new_recipe_page.fill_in_ingredient(0, 'Sugar', 200, 'g', 1.50, 1, 'kg')

      new_recipe_page.fill_in_ingredient(1, 'Butter', 100, 'g', 2, 250, 'g')

      new_recipe_page.fill_in_ingredient(2, 'Flour', 500, 'g', 2, 1.50, 'kg')

      new_recipe_page.fill_in_ingredient(3, 'Egg', 2, 'each', 1, 10, 'each')

      click_link 'Add another ingredient'

      new_recipe_page.fill_in_ingredient(1482253092426, 'Ground almond', 100, 'g', 1.50, 200, 'g')

      click_button 'Create recipe'
      expect(page).to have_current_path(recipe_path(Recipe.last))
      expect(page).to have_content('Mini Bakewells')
    end
  end
end
