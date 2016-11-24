class AddPriceToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :cost, :decimal
  end
end
