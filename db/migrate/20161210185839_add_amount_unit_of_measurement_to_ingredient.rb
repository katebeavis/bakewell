class AddAmountUnitOfMeasurementToIngredient < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :amount_unit_of_measurement, :string
  end
end
