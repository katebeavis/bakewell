class Ingredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :ingredients

  validates :name,
            :amount,
            :price,
            :size,
            presence: true

  accepts_nested_attributes_for :recipe

  before_save :update_unit_price_column

  def convert_price_into_pennies
    price * 100
  end

  def update_unit_price_column
    self.unit_price = calculate_price_per_amount
  end

  def calculate_price_per_unit
    price / size
  end

  def calculate_price_per_amount
    calculate_price_per_unit * amount
  end
end
