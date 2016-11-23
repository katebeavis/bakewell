class Recipe < ApplicationRecord
  has_many :ingredients, inverse_of: :recipe

  validates_presence_of :name, :message => "Please fill in a title"

  accepts_nested_attributes_for :ingredients
end
