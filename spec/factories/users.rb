FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'some_string'
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name

    factory :user_with_recipe, parent: :user do
      recipes {[ create(:recipe_with_cost) ]}
    end
  end
end
