class Recipe < ApplicationRecord
  has_many :ingredients, inverse_of: :recipe, :dependent => :destroy
  has_many :notes, inverse_of: :recipe, :dependent => :destroy

  belongs_to :user

  validates_presence_of :name, :message => "Please fill in a title"

  accepts_nested_attributes_for :ingredients, :allow_destroy => true

  def calculate_cost
    self.ingredients.map { |i| i['unit_price'] }.reduce(:+)
  end

  def calculate_portion_cost
    (calculate_cost / self.quantity).round(2) if self.quantity
  end
end
