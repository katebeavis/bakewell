module Pages
  class NewRecipe
    include Capybara::DSL

    def fill_in_title
      fill_in 'recipe[name]', with: 'Mini Bakewells'
    end

    def fill_in_ingredient(index, name, amount, amount_unit, price, size, size_unit)
      fill_in "recipe[ingredients_attributes][#{index}][name]", with: name
      fill_in "recipe[ingredients_attributes][#{index}][amount]", with: amount
      select amount_unit, from: "recipe[ingredients_attributes][#{index}][amount_unit_of_measurement]"
      fill_in "recipe[ingredients_attributes][#{index}][price]", with: price
      fill_in "recipe[ingredients_attributes][#{index}][size]", with: size
      select size_unit, from: "recipe[ingredients_attributes][#{index}][size_unit_of_measurement]"
    end
  end
end
