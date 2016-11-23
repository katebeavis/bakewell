class Ingredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :ingredients

  accepts_nested_attributes_for :recipe
end
