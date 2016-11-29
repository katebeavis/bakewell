FactoryGirl.define do
  factory :recipe do
    name "Mini Bakewells"
    association :user

    factory :recipe_with_ingredients do
      after(:create) do |recipe|
        create(:sugar, recipe: recipe)
        create(:egg, recipe: recipe)
        create(:flour, recipe: recipe)
        create(:cocoa, recipe: recipe)
        create(:baking_powder, recipe: recipe)
        create(:salt, recipe: recipe)
        create(:milk, recipe: recipe)
      end

      factory :recipe_with_cost do
        cost 2.50
      end

      factory :recipe_with_cost_2 do
        cost 2.50
      end
    end
    
  end
end
