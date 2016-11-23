class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.order(updated_at: :desc)
  end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, ingredients_attributes: [:id, :name, :amount])
  end
end
