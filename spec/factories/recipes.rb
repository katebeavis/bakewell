FactoryGirl.define do
  factory :recipe do
    name "Mini Bakewells"

    factory :recipe_with_ingredients do
      after(:create) do |recipe|
        create(:ingredient, recipe: recipe)
      end

      factory :recipe_with_cost do
        after(:create) do |recipe|
          create(:ingredient, recipe: recipe)
        end
        cost 2.50
      end
    end
    
  end
end
