require 'will_paginate/array'

class RecipesController < ApplicationController
  respond_to :html, :js

  def index
    @recipes = current_user.recipes.search(params[:search]).order(updated_at: :desc)
  end

  def new
    @recipe = Recipe.new
    4.times { @recipe.ingredients.build }
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      @recipe.update_attribute(:cost, @recipe.calculate_cost)
      redirect_to @recipe
    else
      render :new
    end
  end

  def show
    @recipe = current_user.recipes.find(params[:id])
    @notes = @recipe.notes.order(updated_at: :desc)
    @portion_cost = @recipe.calculate_portion_cost
  end

  def edit
    @recipe = current_user.recipes.find(params[:id])
  end

  def update
    @recipe = current_user.recipes.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      @recipe.update_attribute(:cost, @recipe.calculate_cost)
      redirect_to @recipe
    end 
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    flash[:notice] = 'Recipe successfully deleted'
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :quantity, ingredients_attributes: [:id, :name, :amount, :price, :size, :unit_price, :density_unit, :_destroy])
  end
end
