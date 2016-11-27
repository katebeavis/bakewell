FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'some_string'

    factory :user_with_recipe, parent: :user do
      recipes {[ create(:recipe_with_ingredients) ]}
      email { Faker::Internet.email }
    end
  end
end
