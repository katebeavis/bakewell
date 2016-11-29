class AddPriceAndSizeToIngredient < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :price, :decimal
    add_column :ingredients, :size, :decimale
  end
end
