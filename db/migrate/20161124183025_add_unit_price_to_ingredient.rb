class AddUnitPriceToIngredient < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :unit_price, :decimal
  end
end
