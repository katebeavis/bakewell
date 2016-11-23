FactoryGirl.define do
  factory :recipe do
    name "Mini Bakewells"

    factory :recipe_with_ingredients do
      after(:create) do |recipe|
        create(:ingredient, recipe: recipe)
      end
    end
    
  end
end
