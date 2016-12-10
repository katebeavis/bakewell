class Ingredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :ingredients

  validates :name,
            :amount,
            :price,
            :size,
            :amount_unit_of_measurement,
            :size_unit_of_measurement,
            presence: true

  accepts_nested_attributes_for :recipe

  before_save :update_size_unit_column, :if => :size_can_be_converted?
  before_save :update_amount_unit_column, :if => :amount_can_be_converted?
  before_save :update_unit_price_column

  def update_unit_price_column
    self.unit_price = calculate_price_per_amount
  end

  def calculate_price_per_unit
    price / size
  end

  def calculate_price_per_amount
    calculate_price_per_unit * amount
  end

  def update_size_unit_column
    self.size = convert_size_unit
  end

  def update_amount_unit_column
    self.amount = convert_amount_unit
  end

  def is_unit?
    self.amount_unit_of_measurement == 'unit'
  end

  def determine_precision
    (calculate_price_per_unit * 100) < 0.009 ? 4 : 2
  end

  private

  def size_can_be_converted?
    size_unit_is_kg_or_litre? && size_is_less_than_10?
  end

  def amount_can_be_converted?
    amount_unit_is_kg_or_litre? && amount_is_less_than_10?
  end

  def size_is_less_than_10?
    self.size < 10
  end

  def amount_is_less_than_10?
    self.amount < 10
  end

  def convert_size_unit
    self.size * 1000
  end

  def convert_amount_unit
    self.amount * 1000
  end

  def size_unit_is_kg_or_litre?
    self.size_unit_of_measurement == 'kg' || self.size_unit_of_measurement == 'l'
  end

  def amount_unit_is_kg_or_litre?
    self.amount_unit_of_measurement == 'kg' || self.amount_unit_of_measurement == 'l'
  end
end
