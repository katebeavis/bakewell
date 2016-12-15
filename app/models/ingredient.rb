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

  CONVERTABLE_UNITS = ['kg', 'l']

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
    self.size_unit_of_measurement = converted_size_unit
  end

  def update_amount_unit_column
    self.amount = convert_amount_unit
    self.amount_unit_of_measurement = converted_amount_unit
  end

  def is_unit?
    self.amount_unit_of_measurement == 'unit'
  end

  def determine_precision
    (calculate_price_per_unit * 100) < 0.009 ? 4 : 2
  end

  private

  def size_can_be_converted?
    CONVERTABLE_UNITS.include?(size_unit_of_measurement)
  end

  def amount_can_be_converted?
    CONVERTABLE_UNITS.include?(amount_unit_of_measurement)
  end

  def converted_size_unit
    case size_unit_of_measurement
    when 'kg'
      'g'
    when 'l'
      'ml'
    end
  end

  def converted_amount_unit
    case amount_unit_of_measurement
    when 'kg'
      'g'
    when 'l'
      'ml'
    end
  end

  def convert_size_unit
    self.size * 1000
  end

  def convert_amount_unit
    self.amount * 1000
  end
end
