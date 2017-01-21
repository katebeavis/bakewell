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

  CONVERTABLE_UNITS = ['kg', 'l', 'lb', 'tsp', 'tbsp', 'pint']

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
    self.size = (self.size * multiplier("size"))
    self.size_unit_of_measurement = unit_to_convert_to("size")
  end

  def update_amount_unit_column
    self.amount = (self.amount * multiplier("amount"))
    self.amount_unit_of_measurement = unit_to_convert_to("amount")
  end

  def is_each?
    self.amount_unit_of_measurement == 'each'
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

  def unit_to_convert_to(type)
    case self.send("#{type}_unit_of_measurement")
    when 'kg'
      'g'
    when 'l', 'tsp', 'tbsp', 'pint'
      'ml'
    when 'lb'
      'oz'
    end
  end

  def multiplier(type)
    case self.send("#{type}_unit_of_measurement")
    when 'kg', 'l'
      1000
    when 'lb'
      16
    when 'tsp'
      5
    when 'tbsp'
      15
    when 'pint'
      568
    end
  end
end
