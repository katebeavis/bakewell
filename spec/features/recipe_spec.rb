require 'rails_helper'

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

      fill_in 'recipe[name]', with: 'Mini Bakewells'

      fill_in 'recipe[ingredients_attributes][0][name]', with: 'Sugar'
      fill_in 'recipe[ingredients_attributes][0][amount]', with: '200'
      select 'g', from: "recipe[ingredients_attributes][0][amount_unit_of_measurement]"
      fill_in 'recipe[ingredients_attributes][0][price]', with: '1.50'
      fill_in 'recipe[ingredients_attributes][0][size]', with: '1'
      select 'kg', from: "recipe[ingredients_attributes][0][size_unit_of_measurement]"

      fill_in 'recipe[ingredients_attributes][1][name]', with: 'Butter'
      fill_in 'recipe[ingredients_attributes][1][amount]', with: '100'
      select 'g', from: "recipe[ingredients_attributes][1][amount_unit_of_measurement]"
      fill_in 'recipe[ingredients_attributes][1][price]', with: '2'
      fill_in 'recipe[ingredients_attributes][1][size]', with: '250'
      select 'g', from: "recipe[ingredients_attributes][1][size_unit_of_measurement]"

      fill_in 'recipe[ingredients_attributes][2][name]', with: 'Flour'
      fill_in 'recipe[ingredients_attributes][2][amount]', with: '500'
      select 'g', from: "recipe[ingredients_attributes][2][amount_unit_of_measurement]"
      fill_in 'recipe[ingredients_attributes][2][price]', with: '2'
      fill_in 'recipe[ingredients_attributes][2][size]', with: '1.5'
      select 'kg', from: "recipe[ingredients_attributes][2][size_unit_of_measurement]"

      fill_in 'recipe[ingredients_attributes][3][name]', with: 'Egg'
      fill_in 'recipe[ingredients_attributes][3][amount]', with: '2'
      select 'unit', from: "recipe[ingredients_attributes][3][amount_unit_of_measurement]"
      fill_in 'recipe[ingredients_attributes][3][price]', with: '1'
      fill_in 'recipe[ingredients_attributes][3][size]', with: '10'
      select 'unit', from: "recipe[ingredients_attributes][3][size_unit_of_measurement]"

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

  def sign_in(user)
    visit root_path
    click_link 'Get started'
    expect(page).to have_content('Log in')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
