class NotesController < ApplicationController
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @note = @recipe.notes.create(notes_params)
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @note = Note.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @note.destroy
    redirect_to recipe_path(@recipe)
  end

  private

  def notes_params
    params.require(:note).permit(:body)
  end
end
