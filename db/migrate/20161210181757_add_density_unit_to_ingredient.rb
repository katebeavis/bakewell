class AddDensityUnitToIngredient < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :density_unit, :string
  end
end
