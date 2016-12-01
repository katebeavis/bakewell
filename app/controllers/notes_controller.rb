class NotesController < ApplicationController
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @note = @recipe.notes.new(notes_params)
    if @note.save
      redirect_to recipe_path(@recipe, anchor: 'comments')
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @note.destroy
    flash[:notice] = 'Note successfully deleted'
    redirect_to recipe_path(@recipe)
  end

  private

  def notes_params
    params.require(:note).permit(:body)
  end
end
