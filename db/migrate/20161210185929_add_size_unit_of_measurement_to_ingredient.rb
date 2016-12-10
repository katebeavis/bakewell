class AddSizeUnitOfMeasurementToIngredient < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :size_unit_of_measurement, :string
  end
end
