class AddRecipeIdToNote < ActiveRecord::Migration[5.0]
  def change
    add_reference :notes, :recipe, foreign_key: true
  end
end
