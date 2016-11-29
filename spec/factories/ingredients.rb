FactoryGirl.define do
  factory :ingredient do
    factory :sugar do
      name 'Sugar'
      amount 200
      price 2.50
      size 400
      unit_price 4
    end

    factory :egg do
      name 'Egg'
      amount 2
      price 2
      size 10
      unit_price 4
    end

    factory :flour do
      name 'Flour'
      amount 200
      price 2
      size 1500
      unit_price 4
    end

    factory :cocoa do
      name 'Cocoa'
      amount 100
      price 3.50
      size 500
      unit_price 4
    end

    factory :baking_powder do
      name 'Baking Powder'
      amount 14
      price 2
      size 100
      unit_price 4
    end

    factory :salt do
      name 'Salt'
      amount 10
      price 1
      size 500
      unit_price 4
    end

    factory :milk do
      name 'Milk'
      amount 100
      price 1.50
      size 1000
      unit_price 4
    end
  end
end
