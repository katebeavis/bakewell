class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes.all.order(updated_at: :desc)
  end

  def new
    @recipe = Recipe.new
    4.times { @recipe.ingredients.build }
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.errors.any?
      raise fail
    end
    if @recipe.save
      @recipe.update_attribute(:cost, @recipe.calculate_cost)
      redirect_to @recipe
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      @recipe.update_attribute(:cost, @recipe.calculate_cost)
      redirect_to @recipe
    end 
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :quantity, ingredients_attributes: [:id, :name, :amount, :price, :size, :unit_price, :_destroy])
  end
end
