class AddQuantityToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :quantity, :decimal
  end
end
